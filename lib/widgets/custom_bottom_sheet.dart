import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final Function(String) onSubmit;

  CustomBottomSheet({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
        top: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Title
          Text(
            'میخوای چیزی بنویسی؟',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),

          ),
          const SizedBox(height: 16.0),

          // Text Field
          TextField(
            controller: _textController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'اینجا بنویسید...',
              hintTextDirection: TextDirection.rtl,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48.0),
            child: TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.black, // White text
                padding: const EdgeInsets.symmetric(vertical: 12.0), // Adjust padding as needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Smaller curve radius
                ),
              ),
              onPressed: () {
                String enteredText = _textController.text;
                onSubmit(enteredText); // Callback to handle text submission
                Navigator.pop(context); // Close the Bottom Sheet

              },
              child: Container(
                width: double.infinity, // Full width
                alignment: Alignment.center,
                child: const Text(
                  'ثبتش کن',
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
