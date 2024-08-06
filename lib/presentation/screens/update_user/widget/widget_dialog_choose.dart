import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/presentation/screens/update_user/bloc/update_user_cubit.dart';

import '../../../../gen/assets.gen.dart';

class ChooseSourcePicture extends StatelessWidget {
  const ChooseSourcePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () async {
              Navigator.of(context).pop(); // Close the dialog
              await BlocProvider.of<UpdateUserCubit>(context)
                  .getImageFormDevice(ImageSource.gallery);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r)),
              child: Assets.icons.picture.svg(
                  width: 25.w,
                  colorFilter: const ColorFilter.mode(
                      AppColors.colorPrimary, BlendMode.srcIn)),
            ),
          ),
          GestureDetector(
            onTap: () async {
              Navigator.of(context).pop(); // Close the dialog
              await BlocProvider.of<UpdateUserCubit>(context)
                  .getImageFormDevice(ImageSource.camera);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r)),
              child: Assets.icons.camera.svg(
                  width: 25.w,
                  colorFilter: const ColorFilter.mode(
                      AppColors.colorPrimary, BlendMode.srcIn)),
            ),
          ),
        ],
      ),
    );
  }
}
