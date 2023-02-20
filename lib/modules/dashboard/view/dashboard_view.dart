import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/components/app_bar_widget.dart';
import 'package:medihelp/components/default_scaffold.dart';
import 'package:medihelp/modules/splash/view/splash_screen.dart';
import 'package:medihelp/utils/styles.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      appBar: const AppbarWidget(
        title: "MediHelp",
        hideBackButton: true,
      ),
      body: SingleChildScrollView(
        physics: bouncingPhysics,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
