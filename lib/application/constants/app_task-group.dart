import 'package:flutter/material.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/gen/assets.gen.dart';

class AppTaskGroup{
  static final List<Color> listColor = [
    AppColors.pinkSubText,
    AppColors.purple,
    AppColors.yellow,
    Colors.blue,
    AppColors.green,
    AppColors.greenA5,
    AppColors.orange
  ];

  static final List<String> listIcon = [
    Assets.icons.briefcase.path,
    Assets.icons.puzzlePieces.path,
    Assets.icons.bookOpenCover.path,
    Assets.icons.walking.path,
    Assets.icons.userChef.path,
  ];
}
