import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SeekBarScreen extends StatefulWidget {
  const SeekBarScreen({super.key});

  @override
  State<SeekBarScreen> createState() => _SeekBarScreenState();
}

class _SeekBarScreenState extends State<SeekBarScreen> {
  double _currentValue = 0;
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  final List<String> _emotions = [
    '😡', // Very Unhappy
    '😟', // Unhappy
    '😕', // Slightly Unhappy
    '😐', // Neutral
    '🙂', // Slightly Happy
    '😊', // Happy
    '😄'  // Very Happy
  ];

  final List<Color> _backgroundColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.yellowAccent,
    Colors.lightGreen,
    Colors.green,
    Colors.greenAccent,
  ];

  @override
  void initState() {
    super.initState();
    _loadCurrentValue();
  }

  @override
  void dispose() {
    _logCurrentValue();
    super.dispose();
  }
  _loadCurrentValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentValue = (prefs.getDouble('seekBarValue') ?? 0);
    });
  }

  _saveCurrentValue(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('seekBarValue', value);
  }

  _logCurrentValue() async {
    await _analytics.logEvent(
      name: 'seek_bar_value',
      parameters: <String, Object>{
        'value': _currentValue,
        'emotion': _emotions[_currentValue.round()],
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emotion Slider'),
      ),
      body: Center(
        child:
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
                        _saveCurrentValue(value);
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
    path.moveTo(center.dx, center.dy - 24); // Adjusted coordinates for larger size
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