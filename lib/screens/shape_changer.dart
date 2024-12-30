import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:moody/repository/mood_database.dart';

import '../widgets/custom_bottom_sheet.dart';

class ShapeChanger extends StatefulWidget {
  final MoodDatabase moodDatabase;
  ShapeChanger({required this.moodDatabase});

  @override
  _ShapeChangerState createState() => _ShapeChangerState();
}

class _ShapeChangerState extends State<ShapeChanger> {
  late double _sliderValue;
  late Color _currentColor;
  late String _note;

  late String _initialTitle;
  late String _initialLottieFile;
  bool _isFading = false;

  // List of colors, Lottie files, and titles corresponding to slider values
  final List<Color> colors = [
    Color(0xFFDE3D3D),
    Color(0xFF787878),
    Color(0xFFF1F1F1),
    Color(0xFFFFD569),
    Color(0xFF2DDC87)
  ];

  final List<String> lottieFiles = [
    'assets/json/xbad.json',
    'assets/json/bad.json',
    'assets/json/normal.json',
    'assets/json/good.json',
    'assets/json/xgood.json',
  ];

  final List<String> moodTitles = [
    'سگ سیاه افسردگی دورم کرده',
    ' دنیا برام تیره و تاره',
    'همینه که هست، نه بد، نه خوب',
    'خوشی زده زیر دلم',
    'انگار دنیا مال منه',
  ];

  @override
  void initState() {
    super.initState();

    // Set a different initial state
    _initialTitle = 'هی علی امروز چطوری؟';  // Set your custom initial title here
    _initialLottieFile = 'assets/json/normal.json';  // Custom initial Lottie file
    _currentColor = Colors.white;  // Custom initial color
    _sliderValue = -1;
    _note = '';

    _loadState();

  }


  Future<void> _loadState() async {
    final state = await widget.moodDatabase.fetchLatestState();
    if(state!=null){
      setState(() {
        _sliderValue = state.sliderValue;
        _currentColor = Color(state.currentColor);
        _note = state.note ?? '';

      });}

  }

  void _saveState(String enteredText) async {
    await widget.moodDatabase.insertState(_sliderValue, _currentColor.value, enteredText);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('وضعیت ذخیره شد!')),
    );
  }


  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (BuildContext context) {
        return CustomBottomSheet(
          onSubmit: (String enteredText) {
            setState(() {
              _note = enteredText;
            });
            _saveState(enteredText);
          },

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _currentColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Big Title for the mood
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 200,
            child: Text(
              _sliderValue == -1.0 ? _initialTitle : moodTitles[_sliderValue.toInt()],
              style: const TextStyle(
                fontSize: 42, // Adjust the font size as needed
                fontWeight: FontWeight.bold,
                color: Colors.black, // Adjust the color as needed
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20), // Space between the title and the shape

          // Fade-in and fade-out animation for Lottie animation
          _sliderValue == -1 ? Container(
            height: 300,
            width: 300,
          ):AnimatedOpacity(
            opacity: _isFading ? 0.7 : 1.0,
            duration: Duration(milliseconds: 500),
            child: Lottie.asset(
              lottieFiles[_sliderValue.toInt()],
              height: 300,
              width: 300,
              fit: BoxFit.cover,
              delegates: LottieDelegates(
                values: [
                  ValueDelegate.color(
                    const ['**', 'Fill 1', 'Color'], // Adjust this path according to your Lottie file structure
                    value: _currentColor,
                  ),
                ],
              ),
            ),
            onEnd: () {
              setState(() {
                _isFading = !_isFading;
              });
            },
          ),
          SizedBox(height: 50),

          // Slider to control the shape and color
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4.0, // Adjust the thickness of the slider track
                  activeTrackColor: Colors.white, // The color of the track when the thumb is to the right of it
                  inactiveTrackColor: Colors.grey.shade400, // The color of the track when the thumb is to the left of it
                  thumbShape: SquareThumbShape(), // Custom square thumb shape
                  overlayShape: RoundSliderOverlayShape(
                    overlayRadius: 0.0, // Disable overlay effect
                  ),
                  overlayColor: Colors.transparent, // Transparent overlay to match the screenshot
                  trackShape: RoundedRectSliderTrackShape(), // Rounded rectangle shape for the track
                ),
                child: Slider(
                  value: _sliderValue == -1.0 ? 0.0 : _sliderValue, // Adjust slider value for initialization
                  min: 0,
                  max: (lottieFiles.length - 1).toDouble(),
                  divisions: lottieFiles.length - 1,
                  onChanged: (value) {
                    setState(() {
                      _isFading = !_isFading;
                      _sliderValue = value;
                      _currentColor = colors[value.toInt()];
                    });

                  },
                ),
              )
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.black, // White text
                padding: EdgeInsets.symmetric(vertical: 12.0), // Adjust padding as needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Smaller curve radius
                ),
              ),
              onPressed: () {
                setState(() {
                  _showBottomSheet();
                });

              },
              child: Container(
                width: double.infinity, // Full width
                alignment: Alignment.center,
                child: Text(
                  'افزودن متن',
                  style: TextStyle(
                    fontSize: 16, // Adjust the font size as needed
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class SquareThumbShape extends SliderComponentShape {
  final double thumbSize;

  SquareThumbShape({this.thumbSize = 22.0});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbSize, thumbSize);
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
    final Paint paint = Paint()
      ..color = sliderTheme.thumbColor ?? Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final Rect thumbRect = Rect.fromCenter(
      center: center,
      width: thumbSize,
      height: thumbSize,
    );

    context.canvas.drawRect(thumbRect, paint);

    // Draw border
    final Paint borderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0;

    context.canvas.drawRect(thumbRect, borderPaint);
  }
}
