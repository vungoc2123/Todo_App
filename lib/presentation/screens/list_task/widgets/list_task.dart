import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/presentation/screens/list_task/bloc/list_task_cubit.dart';
import 'package:todo/presentation/screens/list_task/bloc/list_task_state.dart';
import 'package:todo/presentation/screens/list_task/widgets/item_task.dart';

class ListTaskWidget extends StatelessWidget {
  final bool isListCompleted;
  final ListTaskState state;

  const ListTaskWidget(
      {super.key, required this.isListCompleted, required this.state});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
          margin: EdgeInsets.only(
              top: isListCompleted &&
                      state.listTaskCompleted.isNotEmpty &&
                      state.listTask.isNotEmpty
                  ? 16.h
                  : 0),
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.r))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isListCompleted && state.listTaskCompleted.isNotEmpty)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: Text(
                    tr("completed"),
                    style: AppTextStyle.textBase
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => Slidable(
                  key: UniqueKey(),
                  endActionPane: ActionPane(
                    extentRatio: 0.2,
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () {
                      if (isListCompleted) {
                        BlocProvider.of<ListTaskCubit>(context)
                            .handleDeleteListVirtual(
                                state.listTaskCompleted[index].id);
                        return;
                      }
                      BlocProvider.of<ListTaskCubit>(context)
                          .handleDeleteListVirtual(state.listTask[index].id);
                    }),
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          if (isListCompleted) {
                            BlocProvider.of<ListTaskCubit>(context)
                                .handleDeleteListVirtual(
                                    state.listTaskCompleted[index].id);
                            return;
                          }
                          BlocProvider.of<ListTaskCubit>(context)
                              .handleDeleteListVirtual(
                                  state.listTask[index].id);
                        },
                        backgroundColor: AppColors.pinkSubText,
                        foregroundColor: AppColors.white,
                        icon: Icons.delete,
                      ),
                    ],
                  ),
                  child: ItemTask(
                    task: isListCompleted
                        ? state.listTaskCompleted[index]
                        : state.listTask[index],
                  ),
                ),
                itemCount: isListCompleted
                    ? state.listTaskCompleted.length
                    : state.listTask.length,
              ),
            ],
          )),
    );
  }
}
