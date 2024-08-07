import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/presentation/common_widgets/app_network_image.dart';

class HeaderWidget extends StatelessWidget {
  final User user;

  const HeaderWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppNetworkImage(
          user.photoURL ?? '',
          width: 80.r,
          height: 80.r,
          radius: 50.r,
          fit: BoxFit.fill,
        ),
        SizedBox(
          width: 10.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${tr('hello')}!",
              style:
                  AppTextStyle.textBase.copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              user.displayName ?? '',
              style: AppTextStyle.textLg.copyWith(fontWeight: FontWeight.w600),
            )
          ],
        )
      ],
    );
  }
}
