import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/domain/models/response/task/task_response.dart';
import 'package:todo/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:todo/presentation/screens/list_task/bloc/list_task_cubit.dart';
import 'package:todo/presentation/screens/list_task/widgets/add_task.dart';
import 'package:todo/presentation/screens/list_task/widgets/update_task.dart';

class ItemTask extends StatelessWidget {
  final TaskResponse task;
  final Color color;

  const ItemTask({super.key, required this.task, this.color = AppColors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 12.w, top: 2.h, bottom: 2.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            activeColor: color,
            value: task.status,
            onChanged: (bool? value) {
              if (value != null) {
                BlocProvider.of<ListTaskCubit>(context)
                    .changeStatusTask(task, value);
              }
            },
          ),
          Expanded(
            child: InkWell(
              onTap: () {
                AppBottomSheet.showBottomSheet(context,
                    child: BlocProvider(
                      create: (BuildContext context) => ListTaskCubit(),
                      child: UpdateTaskWidget(
                        task: task,
                      ),
                    ));
              },
              child: Text(
                task.title,
                style: AppTextStyle.textBase
                    .copyWith(fontWeight: FontWeight.w500, color: color),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
