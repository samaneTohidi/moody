import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:moody/screens/search_user_screen.dart';



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
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.yellowAccent,
    Colors.lightGreen,
    Colors.green,
    Colors.greenAccent,
  ];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadUserEmotionalStatus();
  }

  Future<void> _loadUserEmotionalStatus() async {
    final userDoc =
    FirebaseFirestore.instance.collection('users').doc(widget.user.uid);
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
  }

  Future<void> _updateUserProfile(String emotion) async {
    final userDoc =
    FirebaseFirestore.instance.collection('users').doc(widget.user.uid);
    userDoc.update({
      'emotionalStatus': emotion,
      'updatedAt': Timestamp.now(),
    });

    final statusUpdateDoc =
    FirebaseFirestore.instance.collection('EmotionalStatusUpdates').doc();
    statusUpdateDoc.set({
      'user_id': widget.user.uid,
      'emotional_status': emotion,
      'created_at': Timestamp.now(),
    });

    _notifyFollowers(widget.user.uid, emotion);
  }

  Future<void> _notifyFollowers(String userId, String emotion) async {
    final followersQuery = await FirebaseFirestore.instance
        .collection('followers')
        .where('user_id', isEqualTo: userId)
        .get();

    for (var doc in followersQuery.docs) {
      final followerId = doc['follower_user_id'];
      final notificationDoc =
      FirebaseFirestore.instance.collection('notifications').doc();
      notificationDoc.set({
        'user_id': followerId,
        'from_user_id': userId,
        'notification_type': 'status_update',
        'emotional_status': emotion,
        'created_at': Timestamp.now(),
      });

      // Send notification via FCM (requires FCM setup and integration)
      // await FirebaseMessaging.instance.sendMessage(
      //   to: followerId,
      //   data: {
      //     'title': 'Emotional Status Update',
      //     'body': 'User $userId has updated their status to $emotion',
      //   },
      // );
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
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset('flutterfire_300x.png'),
                        ),
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
                          overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 20.0),
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