import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/domain/models/arguments/update_user_arguments.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/common_widgets/app_button.dart';
import 'package:todo/presentation/common_widgets/app_loading.dart';
import 'package:todo/presentation/common_widgets/app_network_image.dart';
import 'package:todo/presentation/screens/update_user/bloc/update_user_cubit.dart';
import 'package:todo/presentation/screens/update_user/bloc/update_user_state.dart';
import 'package:todo/presentation/screens/update_user/widget/widget_dialog_choose.dart';

import '../../../application/constants/app_colors.dart';
import '../../../application/constants/app_text_style.dart';
import '../../common_widgets/app_label_text_field.dart';

class UpdateUserScreen extends StatefulWidget {
  const UpdateUserScreen({super.key, required this.argument});

  final UserArguments argument;

  @override
  State<UpdateUserScreen> createState() => _UpdateUserScreenState();
}

class _UpdateUserScreenState extends State<UpdateUserScreen>{
  late UpdateUserCubit cubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cubit = BlocProvider.of<UpdateUserCubit>(context);
    cubit.getInfoUser(
        photoUrl: widget.argument.photoUrl,
        userName: widget.argument.userName,
        email: widget.argument.email);
  }



  @override
  Widget build(BuildContext context) {
    final currentTheme = AdaptiveTheme.of(context).theme;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:  SystemUiOverlayStyle(
          statusBarColor: currentTheme.primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: currentTheme.primaryColor,
        title: Text(
          tr("updateUser"),
          style: AppTextStyle.textXl
              .copyWith(fontWeight: FontWeight.w700, color: AppColors.white),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              // image
              GestureDetector(
                onTap: () => {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        title: const Text(
                          "Chọn từ nguồn",
                          textAlign: TextAlign.center,
                        ),
                        content: BlocProvider.value(
                          value: cubit,
                          child: const ChooseSourcePicture(),
                        )),
                  )
                },
                child: BlocBuilder<UpdateUserCubit, UpdateUserState>(
                  builder: (context, state) => Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(99.r),
                        child: AppNetworkImage(
                          state.photoUrl,
                          width: 120.w,
                          height: 120.w,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(99.r)),
                          child: Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: BoxDecoration(
                                color: currentTheme.primaryColor,
                                borderRadius: BorderRadius.circular(99.r)),
                            child: Assets.icons.camera.svg(
                                width: 20,
                                height: 20,
                                colorFilter: const ColorFilter.mode(
                                    AppColors.white, BlendMode.srcIn)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),

              // information
              BlocBuilder<UpdateUserCubit, UpdateUserState>(
                // buildWhen: (previous, current) =>
                //     previous.userName != current.userName &&
                //     previous.status != current.status,
                builder: (context, state) => CustomLabelTextField(
                  label: tr("userName"),
                  defaultValue: state.userName,
                  onChanged: (values) => cubit.changeUserName(values),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              BlocBuilder<UpdateUserCubit, UpdateUserState>(
                builder: (context, state) => Opacity(
                  opacity: 0.5,
                  child: CustomLabelTextField(
                    label: tr("email"),
                    defaultValue: state.email,
                    enable: false,
                  ),
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              AppButton(
                title: tr("save"),
                color: currentTheme.primaryColor,
                textStyle: AppTextStyle.textBase.copyWith(
                  color: AppColors.white,
                ),
                radius: 12.r,
                onPressed: () async {
                  showDialog(context: context, builder: (context) => const AppLoading(),);
                  await cubit.updateInfoUser();
                  if (mounted) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
