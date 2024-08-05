import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/domain/models/response/task/task_response.dart';
import 'package:todo/presentation/common_widgets/app_button.dart';
import 'package:todo/presentation/common_widgets/app_label_text_field.dart';
import 'package:todo/presentation/common_widgets/app_loading.dart';
import 'package:todo/presentation/common_widgets/app_toast.dart';
import 'package:todo/presentation/screens/list_task/bloc/list_task_cubit.dart';
import 'package:todo/presentation/screens/list_task/bloc/list_task_state.dart';

class UpdateTaskWidget extends StatefulWidget {
  final TaskResponse task;

  const UpdateTaskWidget({super.key, required this.task});

  @override
  State<UpdateTaskWidget> createState() => _UpdateTaskWidgetState();
}

class _UpdateTaskWidgetState extends State<UpdateTaskWidget> {
  late final ListTaskCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<ListTaskCubit>(context);
    cubit.change(
        name: widget.task.title,
        description: widget.task.description,
        status: widget.task.status);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListTaskCubit, ListTaskState>(
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
      builder: (BuildContext context, state) {
        return Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16.r),
                  topLeft: Radius.circular(16.r))),
          child: Column(
            children: [
              Text(
                tr("updateTask"),
                style: AppTextStyle.textXl,
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomLabelTextField(
                label: tr("nameTask"),
                backgroundColor: AppColors.white,
                textStyleLabel: AppTextStyle.textBase,
                defaultValue: widget.task.title,
                onChanged: (value) {
                  cubit.change(name: value);
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              CustomLabelTextField(
                label: tr("description"),
                backgroundColor: AppColors.white,
                textStyleLabel: AppTextStyle.textBase,
                defaultValue: widget.task.description,
                maxLine: 5,
                onChanged: (value) {
                  cubit.change(description: value);
                },
              ),
              SizedBox(
                height: 16.h,
              ),
              AppButton(
                title: tr("update"),
                color: AppColors.blue,
                textStyle:
                    AppTextStyle.textBase.copyWith(color: AppColors.white),
                radius: 8.r,
                onPressed: () {
                  cubit.updateTask(widget.task);
                },
              )
            ],
          ),
        );
      },
    );
  }

  Widget itemPriority() {
    return Row(
      children: [
        Radio(
            value: false,
            groupValue: 1,
            activeColor: Color(0xFF6200EE),
            onChanged: (value) {}),
      ],
    );
  }
}
