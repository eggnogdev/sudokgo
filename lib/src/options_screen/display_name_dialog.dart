import 'package:flutter/material.dart';
import 'package:sudokgo/src/hive/hive_wrapper.dart';
import 'package:sudokgo/src/widgets/text_field.dart';

class DisplayNameDialog extends StatefulWidget {
  const DisplayNameDialog({super.key});

  @override
  State<DisplayNameDialog> createState() => _DisplayNameDialogState();
}

class _DisplayNameDialogState extends State<DisplayNameDialog> {
  final TextEditingController controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: SudokGoTextField(
        title: 'enter a new display name',
        suffixButtonOnPressed: () {
          if (controller.value.text == '') return;
          HiveWrapper.setDisplayName(controller.value.text);
          Navigator.pop(context);
        },
        controller: controller,
      ),
    );
  }
}
