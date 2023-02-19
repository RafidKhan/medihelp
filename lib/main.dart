import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/modules/splash/view/splash_screen.dart';
import 'package:medihelp/utils/styles.dart';

void main() {
  runApp(const MediHelp());
}

class MediHelp extends StatelessWidget {
  const MediHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      title: 'MediHelp',
      home: const SplashScreen(),
    );
    ;
  }
}
