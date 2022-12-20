import 'package:flutter/material.dart';
import 'package:flutter_custom_license_page/flutter_custom_license_page.dart';
import 'package:go_router/go_router.dart';
import 'package:sudokgo/src/licenses_screen/licenses_dialog.dart';
import 'package:sudokgo/src/widgets/menu_button.dart';
import 'package:sudokgo/src/widgets/sudokgo_app_bar.dart';

class LicensesScreen extends StatelessWidget {
  const LicensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomLicensePage((context, licenseData) {
      return WillPopScope(
        onWillPop: () async {
          backOnPressed(context);
          return false;
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: SudokGoAppBar.create(
            title: Text(
              'licenses',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            backOnPressed: () {
              backOnPressed(context);
            },
            context: context,
          ),
          body: SingleChildScrollView(
            child: licenseData.connectionState == ConnectionState.done ?
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  ...licenseData.data!.packages.map(
                    (currentPackage) => Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: SudokGoMenuButton(
                        width: MediaQuery.of(context).size.width / 1.25,
                        title: currentPackage,
                        subtitle: '${licenseData.data!.packageLicenseBindings[currentPackage]!.length} licenses',
                        onPressed: () {
                          final packageLicenses = licenseData.data!.packageLicenseBindings[currentPackage]!.map(
                            (binding) => licenseData.data!.licenses[binding]
                          ).toList();
                          showDialog(
                            context: context,
                            builder: (context) => LicensesDialog(
                              currentPackage: currentPackage,
                              packageLicenses: packageLicenses,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ]
              ),
            ) :
            const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    });
  }

  void backOnPressed(BuildContext context) {
    GoRouter.of(context).go('/options');
  }
}
