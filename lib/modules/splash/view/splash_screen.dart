import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/components/default_scaffold.dart';
import 'package:medihelp/gen/assets.gen.dart';
import 'package:medihelp/modules/authentication/login/view/login_view.dart';
import 'package:medihelp/modules/bottom_nav_page/view/bottom_nav_page.dart';
import 'package:medihelp/utils/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    checkUserStatus();
    super.initState();
  }

  Future<void> checkUserStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      Get.off(() => const BottomNavScreen(), transition: defaultPageTransition);
    } else {
      Get.off(() => const LoginView(), transition: defaultPageTransition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: Image.asset(
            Assets.logo.appLogo.path,
            height: 100,
            width: 100,
          ),
        ));
  }
}
