import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/presentation/common_widgets/app_button.dart';
import 'package:todo/presentation/common_widgets/app_label_text_field.dart';
import 'package:todo/presentation/common_widgets/app_loading.dart';
import 'package:todo/presentation/common_widgets/app_toast.dart';
import 'package:todo/presentation/screens/list_task/bloc/list_task_cubit.dart';
import 'package:todo/presentation/screens/list_task/bloc/list_task_state.dart';

class AddTaskWidget extends StatefulWidget {
  final String idTaskGroup;

  const AddTaskWidget({super.key, required this.idTaskGroup});

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  late final ListTaskCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<ListTaskCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = AdaptiveTheme.of(context).theme;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: BlocListener<ListTaskCubit, ListTaskState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (BuildContext context, state) {
          if (LoadStatus.loading == state.status) {
            showDialog(
                context: context,
                builder: (context) => const AppLoading(),
                barrierDismissible: false);
          }
          if (LoadStatus.success == state.status) {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            AppToast.showToastSuccess(context, title: tr('success'));
          }
        },
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16.r), topLeft: Radius.circular(16.r))),
          child: Column(
            children: [
              Text(
                tr("addTask"),
                style: AppTextStyle.textXl,
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomLabelTextField(
                label: tr("nameTask"),
                backgroundColor: AppColors.white,
                textStyleLabel: AppTextStyle.textBase,
                onChanged: (value) {
                  cubit.change(name: value);
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomLabelTextField(
                label: "${tr("description")} (${tr("optional")})",
                backgroundColor: AppColors.white,
                textStyleLabel: AppTextStyle.textBase,
                onChanged: (value) {
                  cubit.change(description: value);
                },
                maxLine: 5,
              ),
              SizedBox(
                height: 16.h,
              ),
              AppButton(
                title: tr("add"),
                color: currentTheme.primaryColor,
                radius: 8.r,
                textStyle: AppTextStyle.textBase.copyWith(color: AppColors.white),
                onPressed: () {
                  cubit.addTask(widget.idTaskGroup);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
