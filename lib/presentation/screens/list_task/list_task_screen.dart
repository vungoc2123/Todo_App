import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/application/utils/navigation_utils.dart';
import 'package:todo/domain/models/arguments/list_task_arguments.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:todo/presentation/common_widgets/app_float_button.dart';
import 'package:todo/presentation/common_widgets/app_label_text_field.dart';
import 'package:todo/presentation/common_widgets/app_loading_indicator.dart';
import 'package:todo/presentation/screens/list_task/bloc/list_task_cubit.dart';
import 'package:todo/presentation/screens/list_task/bloc/list_task_state.dart';
import 'package:todo/presentation/screens/list_task/widgets/add_task.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/screens/list_task/widgets/list_task.dart';

class ListTaskScreen extends StatefulWidget {
  final ListTaskArguments argument;

  const ListTaskScreen({super.key, required this.argument});

  @override
  State<ListTaskScreen> createState() => _ListTaskScreenState();
}

class _ListTaskScreenState extends State<ListTaskScreen> with RouteAware {
  late final ListTaskCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<ListTaskCubit>(context);
    cubit.getList(widget.argument.id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NavigatorUtils.navigatorObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    cubit.getList(widget.argument.id);
  }

  @override
  void dispose() {
    super.dispose();
    NavigatorUtils.navigatorObserver.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = AdaptiveTheme.of(context).theme;

    return Scaffold(
      backgroundColor: AppColors.grayF3,
      appBar: AppBar(
        title: Text(
          tr("listTask"),
          style: AppTextStyle.textBase
              .copyWith(fontWeight: FontWeight.w600, color: AppColors.white),
        ),
        backgroundColor: currentTheme.primaryColor,
        foregroundColor: AppColors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          children: [
            CustomLabelTextField(
              hintText: tr('search'),
              backgroundColor: AppColors.white,
              colorBorder: AppColors.grayD1,
              textStyleHint:
                  AppTextStyle.textBase.copyWith(color: AppColors.grey),
              prefixIcon: Assets.icons.search.svg(
                  width: 20.r,
                  height: 20.r,
                  colorFilter:
                      const ColorFilter.mode(AppColors.grey, BlendMode.srcIn)),
              onChanged: (value) {
                cubit.filterList(value);
              },
            ),
            SizedBox(
              height: 8.h,
            ),
            BlocBuilder<ListTaskCubit, ListTaskState>(
              buildWhen: (previous, current) =>
                  previous.listTask != current.listTask ||
                  previous.listTaskCompleted != current.listTaskCompleted ||
                  previous.status != current.status ||
                  previous.listTaskCompletedInit !=
                      current.listTaskCompletedInit ||
                  previous.listTaskInit != current.listTaskInit,
              builder: (BuildContext context, ListTaskState state) {
                if (state.listTask.isEmpty &&
                    state.listTaskCompleted.isEmpty &&
                    state.status == LoadStatus.initial) {
                  return Center(
                    child: SizedBox(
                      height: 120.h,
                      child: const AppLoadingIndicator(
                        color: AppColors.colorPrimary,
                      ),
                    ),
                  );
                }
                if (state.listTask.isEmpty &&
                    state.listTaskCompleted.isEmpty &&
                    state.status != LoadStatus.initial) {
                  return Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Assets.images.task.image(width: 100.r, height: 100.r),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          tr('youHaveNotTask'),
                          style: AppTextStyle.textBase,
                        )
                      ],
                    ),
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTaskWidget(
                        isListCompleted: false,
                        state: state,
                      ),
                      ListTaskWidget(
                        isListCompleted: true,
                        state: state,
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: AppFloatButton(
        onPress: () {
          AppBottomSheet.showBottomSheet(context,
              child: BlocProvider.value(
                value: cubit,
                child: AddTaskWidget(
                  idTaskGroup: widget.argument.id,
                ),
              ));
        },
      ),
    );
  }
}
