import 'package:flutter/material.dart';
import 'package:medihelp/utils/styles.dart';

class DefaultScaffold extends StatelessWidget {
  Color? backgroundColor;
  Widget body;
  Widget? appBar;
  Widget? bottomNavigationBar;
  Widget? floatingActionButton;

  DefaultScaffold({
    Key? key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor = kWhiteColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar == null
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(appBarHeight),
                child: appBar!,
              ),
        body: body,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
