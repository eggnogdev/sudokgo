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
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      content: SudokGoTextField(
        controller: controller,
        title: 'enter your friend\'s email',
        suffixButtonIcon: loading ? const CircularProgressIndicator() : null,
        subText: subText,
        subTextIsError: subTextIsError,
        suffixButtonOnPressed: () async {
          if (mounted)
            setState(() {
              subText = '';
              subTextIsError = false;
              loading = true;
            });
          final String input = controller.text.trim();
          if (input != '') {
            try {
              await SudokGoApi.addFriend(input);
              if (mounted)
                setState(() {
                  subText = 'friend request sent';
                });
            } on YouAreYourOwnBestFriendException catch (error) {
              if (mounted)
                setState(() {
                  subText = error.msg;
                });
            } on SudokGoException catch (error) {
              if (mounted)
                setState(() {
                  subText = error.msg;
                  subTextIsError = true;
                });
            } catch (error) {
              if (mounted)
                setState(() {
                  subText = 'unexpected error';
                  subTextIsError = true;
                });
            }
          }
          if (mounted)
            setState(() {
              loading = false;
            });
        },
      ),
    );
  }

  void updateSubText({required String text, required bool isError}) {
    if (mounted)
      setState(() {
        subText = text;
        subTextIsError = isError;
      });
  }
}
