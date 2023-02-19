import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:medihelp/utils/styles.dart';

class LoaderWidget extends StatelessWidget {
  final double? size;

  LoaderWidget({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitThreeBounce(
        color: kPrimaryColor,
        size: size ?? 30,
      ),
    );
  }
}
