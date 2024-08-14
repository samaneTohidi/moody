import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moody/screens/search_user_screen.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';
import '../models/emotional_status_update_model.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  double _currentValue = 0;

  final List<String> _emotions = ['😡', '😟', '😕', '😐', '🙂', '😊', '😄'];

  final List<Color> _backgroundColors = [
    Colors.red.shade700,
    Colors.orange.shade700,
    Colors.yellow.shade700,
    Colors.yellowAccent,
    Colors.lightGreen.shade700,
    Colors.green.shade700,
    Colors.greenAccent.shade400,
  ];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadUserEmotionalStatus();
    _initializeNotifications();
    _saveFCMToken();
    FirebaseMessaging.onMessage.listen(_handleMessage);
  }

  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> _saveFCMToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        final userDoc = FirebaseFirestore.instance.collection('users').doc(widget.user.uid);
        await userDoc.update({'fcmToken': token});
      }
    } catch (e) {
      print('Error saving FCM token: $e');
    }
  }

  Future<void> _loadUserEmotionalStatus() async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(widget.user.uid);
      final docSnapshot = await userDoc.get();
      if (docSnapshot.exists) {
        final emotionalStatus = docSnapshot.data()?['emotionalStatus'] ?? '🙂';
        final index = _emotions.indexOf(emotionalStatus);
        if (index != -1) {
          setState(() {
            _currentValue = index.toDouble();
          });
        }
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading user emotional status: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateUserProfile(String emotion) async {
    try {
      final userDoc = FirebaseFirestore.instance.collection('users').doc(widget.user.uid);
      await userDoc.update({'emotionalStatus': emotion, 'updatedAt': Timestamp.now()});

      final statusUpdateDoc = FirebaseFirestore.instance.collection('EmotionalStatusUpdates').doc();
      final statusUpdate = EmotionalStatusUpdateModel(
        updateId: statusUpdateDoc.id,
        userId: widget.user.uid,
        emotionalStatus: emotion,
        createdAt: Timestamp.now(),
      );

      await statusUpdateDoc.set(statusUpdate.toJson());
      _notifyFollowers(widget.user.uid, emotion);
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  Future<void> _notifyFollowers(String userId, String emotion) async {
    try {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      final userEmail = userDoc.data()?['email'] ?? 'Unknown';

      final followersQuery = await FirebaseFirestore.instance.collection('followers').where('user_id', isEqualTo: userId).get();

      for (var doc in followersQuery.docs) {
        final followerId = doc['follower_user_id'];
        final followerDoc = await FirebaseFirestore.instance.collection('users').doc(followerId).get();
        final token = followerDoc.data()?['fcmToken'];

        if (token != null) {
          await _sendFCMNotification(token, userEmail, emotion);
        }
      }
    } catch (e) {
      print('Error notifying followers: $e');
    }
  }

  Future<void> _sendFCMNotification(String token, String userEmail, String emotion) async {

    try {
      final String projectId = dotenv.env['PROJECT_ID'] ?? 'Not Found';
      final String privateKeyId = dotenv.env['PRIVATE_KEY_ID'] ?? 'Not Found';
      final String privateKey = dotenv.env['PRIVATE_KEY'] ?? 'Not Found';
      final String clientEmail = dotenv.env['CLIENT_EMAIL'] ?? 'Not Found';
      final String clientId = dotenv.env['CLIENT_ID'] ?? 'Not Found';
      final String authUri = dotenv.env['AUTH_URI'] ?? 'Not Found';
      final String tokenUri = dotenv.env['TOKEN_URI'] ?? 'Not Found';
      final String authProviderCertUrl = dotenv.env['AUTH_PROVIDER_CERT_URL'] ?? 'Not Found';
      final String clientCertUrl = dotenv.env['CLIENT_CERT_URL'] ?? 'Not Found';
      final String serviceAccountKeyString = '''
    {
      "type": "service_account",
      "project_id": "$projectId",
      "private_key_id": "$privateKeyId",
      "private_key": "$privateKey",
      "client_email": "$clientEmail",
      "client_id": "$clientId",
      "auth_uri": "$authUri",
      "token_uri": "$tokenUri",
      "auth_provider_x509_cert_url": "$authProviderCertUrl",
      "client_x509_cert_url": "$clientCertUrl",
      "universe_domain": "googleapis.com"
    } ''';

      if (serviceAccountKeyString == 'Not Found') {
        throw Exception('Service Account Key not found in environment variables');
      }

      final credentials = ServiceAccountCredentials.fromJson(serviceAccountKeyString);
      final client = await clientViaServiceAccount(credentials, ['https://www.googleapis.com/auth/firebase.messaging']);
      final accessToken = (await client.credentials).accessToken.data;

      final fcmEndpoint = 'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';

      final message = {
        'message': {
          'token': token,
          'notification': {
            'title': 'Emotional Status Update',
            'body': 'Your friend $userEmail updated their status to $emotion',
          },
        }
      };

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken',
      };

      final response = await http.post(
        Uri.parse(fcmEndpoint),
        headers: headers,
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('FCM request for device sent!');
      } else {
        print('FCM request for device failed with status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending FCM notification: $e');
    }
  }

  void _handleMessage(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel', // id
            'High Importance Notifications', // title
            channelDescription: 'This channel is used for important notifications.', // description
            icon: android.smallIcon,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Emotions'),
            Tab(text: 'Followers'),
            Tab(text: 'Following'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchUserScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    appBar: AppBar(
                      title: const Text('User Profile'),
                    ),
                    actions: [
                      SignedOutAction((context) {
                        Navigator.of(context).pop();
                      })
                    ],
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        // child: AspectRatio(
                        //   aspectRatio: 1,
                        //   child: Image.asset('flutterfire_300x.png'),
                        // ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(
                  children: [
                    SizedBox(
                      height: 100,
                      child: Row(
                        children: List.generate(7, (index) {
                          return Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  color: _backgroundColors[index],
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      _emotions[index],
                                      style: const TextStyle(fontSize: 24),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          trackHeight: 10.0,
                          thumbColor: Colors.yellow,
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: Colors.white,
                          overlayColor: Colors.yellow.withOpacity(0.2),
                          thumbShape: LightningThumbShape(),
                          overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
                        ),
                        child: Slider(
                          value: _currentValue,
                          min: 0,
                          max: 6,
                          divisions: 6,
                          onChanged: (value) {
                            setState(() {
                              _currentValue = value;
                            });
                            _updateUserProfile(_emotions[value.round()]);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Current Emotion: ${_emotions[_currentValue.round()]}',
                  style: const TextStyle(fontSize: 24),
                ),
              ],
            ),
          ),
          FollowersList(userId: widget.user.uid),
          FollowingList(userId: widget.user.uid),
        ],
      ),
    );
  }
}

class LightningThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(48, 48);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    final Paint fillPaint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.yellow
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.yellowAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    Path path = Path();
    path.moveTo(center.dx, center.dy - 24);
    path.lineTo(center.dx - 12, center.dy);
    path.lineTo(center.dx, center.dy);
    path.lineTo(center.dx - 12, center.dy + 24);
    path.lineTo(center.dx + 12, center.dy - 12);
    path.lineTo(center.dx, center.dy - 12);
    path.close();

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);
  }
}

class FollowersList extends StatelessWidget {
  final String userId;

  const FollowersList({required this.userId, Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> _getFollowersDetails() async {
    final followersSnapshots = await FirebaseFirestore.instance
        .collection('followers')
        .where('user_id', isEqualTo: userId)
        .get();

    List<Map<String, dynamic>> followersDetails = [];

    for (var doc in followersSnapshots.docs) {
      final followerUserId = doc['follower_user_id'];
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(followerUserId).get();

      if (userDoc.exists) {
        followersDetails.add({
          'email': userDoc['email'],
          'emotionalStatus': userDoc['emotionalStatus'],
        });
      }
    }

    return followersDetails;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _getFollowersDetails(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            final followerData = snapshot.data?[index];
            return ListTile(
              title: Text(followerData?['email'] ?? 'Unknown'),
              subtitle: Text(followerData?['emotionalStatus'] ?? 'Unknown'),
            );
          },
        );
      },
    );
  }
}

class FollowingList extends StatelessWidget {
  final String userId;

  const FollowingList({required this.userId, Key? key}) : super(key: key);

  Future<List<Map<String, dynamic>>> _getFollowingDetails() async {
    final followingSnapshots = await FirebaseFirestore.instance
        .collection('followers')
        .where('follower_user_id', isEqualTo: userId)
        .get();

    List<Map<String, dynamic>> followingDetails = [];

    for (var doc in followingSnapshots.docs) {
      final followingUserId = doc['user_id'];
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(followingUserId).get();

      if (userDoc.exists) {
        followingDetails.add({
          'email': userDoc['email'],
          'emotionalStatus': userDoc['emotionalStatus'],
        });
      }
    }

    return followingDetails;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _getFollowingDetails(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (context, index) {
            final followingData = snapshot.data?[index];
            return ListTile(
              title: Text(followingData?['email'] ?? 'Unknown'),
              subtitle: Text(followingData?['emotionalStatus'] ?? 'Unknown'),
            );
          },
        );
      },
    );
  }
}