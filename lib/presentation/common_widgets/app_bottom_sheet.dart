import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomSheet {
  static Future<bool?> showBottomSheet(BuildContext context,
      {required Widget child}) async {
    return showModalBottomSheet<bool?>(
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
