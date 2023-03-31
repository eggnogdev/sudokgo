import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LicensesDialog extends StatelessWidget {
  const LicensesDialog({
    super.key,
    required this.currentPackage,
    required this.packageLicenses,
  });

  final String currentPackage;
  final List<LicenseEntry> packageLicenses;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                currentPackage,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 20.0,
                ),
              ),
              Text(
                packageLicenses
                    .map(
                      (e) => e.paragraphs.map((e) => e.text).toList().reduce(
                            (value, element) => '$value\n$element',
                          ),
                    )
                    .reduce(
                      (value, element) => '$value\n\n$element',
                    ),
              ),
            ],
          ),
        ));
  }
}
