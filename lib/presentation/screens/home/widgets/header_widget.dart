import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/presentation/common_widgets/app_network_image.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppNetworkImage(
          "https://chiemtaimobile.vn/images/companies/1/%E1%BA%A2nh%20Blog/avatar-facebook-dep/Anh-avatar-hoat-hinh-de-thuong-xinh-xan.jpg?1704788263223",
          width: 80.r,
          height: 80.r,
          radius: 50.r,
        ),
        SizedBox(width: 10.h,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello!",
              style:
                  AppTextStyle.textBase.copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              "Livia Vaccaro",
              style:
                  AppTextStyle.textLg.copyWith(fontWeight: FontWeight.w600),
            )
          ],
        )
      ],
    );
  }
}
