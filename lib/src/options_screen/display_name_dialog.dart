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
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'enter a new display name',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(height: 10.0,),
          SudokGoTextField(
            enterOnPressed: () {
              if (controller.value.text == '') return;
              HiveWrapper.setDisplayName(controller.value.text);
              Navigator.pop(context);
            },
            controller: controller,
          ),
        ],
      ),
    );
  }
}
