import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomSheet {
  static Future<void> showBottomSheet(BuildContext context,
      {required Widget child}) async {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SizedBox(
              width: 1.sw,
              child: SingleChildScrollView(child: child)
          );
        });
  }
}
