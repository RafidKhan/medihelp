import 'package:flutter/material.dart';
import 'package:medihelp/components/default_scaffold.dart';
import 'package:medihelp/gen/assets.gen.dart';
import 'package:medihelp/utils/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
