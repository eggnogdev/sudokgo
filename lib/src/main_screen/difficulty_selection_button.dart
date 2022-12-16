import 'package:flutter/material.dart';

class DifficultySelectionButton extends StatelessWidget {
  const DifficultySelectionButton({
    super.key,
    required this.title,
    required this.bestTime,
    required this.onPressed,
  });

  final String title;
  final String bestTime;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 1.25,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            foregroundColor: null,
            backgroundColor: Theme.of(context).primaryColorLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            )),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28.0,
                    ),
                  ),
                  Text(
                    'best time: $bestTime',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              const Text(
                '>',
                style: TextStyle(
                  fontSize: 48.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
