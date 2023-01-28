import 'package:flutter/material.dart';
import 'package:sudokgo/src/api/api.dart';
import 'package:sudokgo/src/widgets/text_field.dart';

class AddFriendDialog extends StatefulWidget {
  const AddFriendDialog({super.key});

  @override
  State<AddFriendDialog> createState() => _AddFriendDialogState();
}

class _AddFriendDialogState extends State<AddFriendDialog> {
  String subText = '';
  bool subTextIsError = false;
  bool loading = false;
  final controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      content: SudokGoTextField(
        controller: controller,
        title: 'enter your friend\'s email',
        suffixButtonIcon: loading ?
          const CircularProgressIndicator() :
          null,
        subText: subText,
        subTextIsError: subTextIsError,
        suffixButtonOnPressed: () async {
          setState(() {
            subText = '';
            subTextIsError = false;
            loading = true;
          });
          final String input = controller.text.trim();
          if (input != '') {
            try {
              await SudokGoApi.addFriend(input);
              setState(() {
                subText = 'friend request sent';
              });
            } on YouAreYourOwnBestFriendException catch (error) {
              setState(() {
                subText = error.msg;
              });
            } on SudokGoException catch (error) {
              setState(() {
                subText = error.msg;
                subTextIsError = true;
              });
            } catch (error) {
              setState(() {
                subText = 'unexpected error';
                subTextIsError = true;
              });
            }
          }
          setState(() {
            loading = false;
          });
        },
      ),
    );
  }

  void updateSubText({required String text, required bool isError}) {
    setState(() {
      subText = text;
      subTextIsError = isError;
    });
  }
}