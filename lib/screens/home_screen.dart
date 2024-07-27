import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
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
          )
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
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
          ],
        ),
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
