import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/modules/splash/view/splash_screen.dart';
import 'package:medihelp/utils/styles.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
