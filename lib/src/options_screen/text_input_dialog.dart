import 'package:flutter/material.dart';
import 'package:sudokgo/src/widgets/text_field.dart';

class TextInputDialog extends StatelessWidget {
 TextInputDialog({super.key, required this.prompt, required this.onSubmit,});

  final Function(String text) onSubmit;
  final String prompt;

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: SudokGoTextField(
        title: prompt,
        suffixButtonOnPressed: () {
          onSubmit(controller.text);
        },
        controller: controller,
      ),
    );
  }
}
