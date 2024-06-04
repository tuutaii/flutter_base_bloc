import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key? key,
    this.width = 30.0,
    this.color,
    this.isSeparatePlatform = true,
    this.strokeWidth = 2.0,
    this.padding = 10.0,
  }) : super(key: key);
  final double strokeWidth, padding;
  final double width;
  final Color? color;
  final bool isSeparatePlatform;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: SizedBox(
          width: width,
          height: width,
          child: Platform.isAndroid || !isSeparatePlatform
              ? CircularProgressIndicator(
                  color: color ?? Theme.of(context).primaryColor,
                  strokeWidth: strokeWidth,
                )
              : CupertinoActivityIndicator(
                  color: color ?? Theme.of(context).primaryColor,
                ),
        ),
      ),
    );
  }
}
