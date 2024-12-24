import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static const String _sliderValueKey = "sliderValue";
  static const String _currentColorKey = "currentColor";
  static const String _textKey = "enteredText";


  // Save the state
  static Future<void> saveState(double sliderValue, Color currentColor) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_sliderValueKey, sliderValue);
    await prefs.setInt(_currentColorKey, currentColor.value);
    print("State Saved: Slider: $sliderValue, Color: ${currentColor.value}");

  }

// Load the state
  static Future<Map<String, dynamic>> loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final sliderValue =
        prefs.getDouble(_sliderValueKey) ?? -1.0; // Default value for slider
    final currentColorValue =
        prefs.getInt(_currentColorKey) ?? Colors.white.value; // Default color
    final currentColor = Color(currentColorValue);

    return {
      'sliderValue': sliderValue,
      'currentColor': currentColor,
    };
  }

  // Save text
  static Future<void> saveText(String text) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_textKey, text);
    print("Text Saved: $text");
  }

// Load text
  static Future<String> loadText() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_textKey) ?? ''; // Default value is an empty string
  }

}
