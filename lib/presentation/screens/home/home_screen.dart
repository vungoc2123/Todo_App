import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/application/utils/navigation_utils.dart';
import 'package:todo/domain/models/arguments/list_task_arguments.dart';
import 'package:todo/domain/models/response/task/task_group_response.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/common_widgets/app_bottom_sheet.dart';
import 'package:todo/presentation/common_widgets/app_float_button.dart';
import 'package:todo/presentation/common_widgets/app_loading_indicator.dart';
import 'package:todo/presentation/common_widgets/app_toast.dart';
import 'package:todo/presentation/routes/route_name.dart';
import 'package:todo/presentation/screens/home/bloc/task_group_cubit.dart';
import 'package:todo/presentation/screens/home/bloc/task_group_state.dart';
import 'package:todo/presentation/screens/home/widgets/add_task_group.dart';
import 'package:todo/presentation/screens/home/widgets/header_widget.dart';
import 'package:todo/presentation/screens/home/widgets/item_task.dart';
import 'package:todo/presentation/screens/home/widgets/udpate_task_group.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with RouteAware {
  late final TaskGroupCubit cubit;
  late User user;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<TaskGroupCubit>(context);
    cubit.getList();
    user = FirebaseAuth.instance.currentUser!;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NavigatorUtils.navigatorObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    cubit.getList();
    user = FirebaseAuth.instance.currentUser!;
  }

  @override
  void dispose() {
    super.dispose();
    NavigatorUtils.navigatorObserver.unsubscribe(this);
  }

  void handleUpdate(int index) {
    TaskGroupResponse taskGroupResponse = TaskGroupResponse(
        id: cubit.state.taskGroups[index].id,
        color: cubit.state.taskGroups[index].color,
        icon: cubit.state.taskGroups[index].icon,
        title: cubit.state.taskGroups[index].title,
        totalTask: cubit.state.taskGroups[index].quantity,
        uid: cubit.state.taskGroups[index].uid,
        createAt: cubit.state.taskGroups[index].createAt);

    AppBottomSheet.showBottomSheet(context,
        child: BlocProvider(
            create: (BuildContext context) => TaskGroupCubit(),
            child: UpdateTaskGroup(taskGroupResponse: taskGroupResponse)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.grayF3,
        body: SafeArea(
          child: Container(
            width: 1.sw,
            height: 1.sh,
            padding: EdgeInsets.all(16.r),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              HeaderWidget(
                user: user,
              ),
              SizedBox(height: 20.h),
              title(),
              SizedBox(height: 20.h),
              Expanded(
                child: BlocConsumer<TaskGroupCubit, TaskGroupState>(
                  listener: (BuildContext context, TaskGroupState state) {
                    if (state.status == LoadStatus.failure) {
                      AppToast.showToastError(context,
                          title: tr('processFailed'));
                    }
                  },
                  listenWhen: (previous, current) =>
                      previous.status != current.status,
                  buildWhen: (previous, current) =>
                      previous.taskGroups != current.taskGroups ||
                      previous.status != current.status,
                  builder: (BuildContext context, state) {
                    if (state.taskGroups.isEmpty &&
                        state.status != LoadStatus.initial) {
                      return Expanded(
                        child: SizedBox(
                          width: 1.sw,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Assets.images.teamWork
                                  .image(width: 100.r, height: 100.r),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                tr('youHaveNotTaskGroup'),
                                style: AppTextStyle.textBase,
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    if (state.status == LoadStatus.initial &&
                        state.taskGroups.isEmpty) {
                      return Center(
                        child: SizedBox(
                          height: 120.h,
                          child: const AppLoadingIndicator(
                            color: AppColors.colorPrimary,
                          ),
                        ),
                      );
                    }
                    return SingleChildScrollView(
                      child: ListView.separated(
                        itemCount: state.taskGroups.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ClipRRect(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16.r))),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16.r),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      RouteName.listTask,
                                      arguments: ListTaskArguments(
                                          id: state.taskGroups[index].id));
                                },
                                child: Slidable(
                                    key: UniqueKey(),
                                    endActionPane: ActionPane(
                                      extentRatio: 0.4,
                                      motion: const ScrollMotion(),
                                      dismissible:
                                          DismissiblePane(onDismissed: () {
                                        cubit.deleteTaskGroup(
                                            state.taskGroups[index].id);
                                      }),
                                      children: [
                                        SlidableAction(
                                          onPressed: (context) {
                                            handleUpdate(index);
                                          },
                                          autoClose: false,
                                          backgroundColor: AppColors.yellow,
                                          foregroundColor: Colors.white,
                                          icon: Icons.edit,
                                        ),
                                        SlidableAction(
                                          onPressed: (context) {
                                            cubit.deleteTaskGroup(
                                                state.taskGroups[index].id);
                                          },
                                          backgroundColor: AppColors.pinkSubText,
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                        ),
                                      ],
                                    ),
                                    child: ItemTaskGroup(
                                        itemTaskGroupModel:
                                            state.taskGroups[index])),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                          height: 16.h,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
        floatingActionButton: AppFloatButton(
          onPress: () {
            AppBottomSheet.showBottomSheet(context,
                child: BlocProvider(
                    create: (BuildContext context) => TaskGroupCubit(),
                    child: const AddTaskGroup()));
          },
        ));
  }

  Widget title() {
    return Text(
      tr('taskGroup'),
      style: AppTextStyle.textXl.copyWith(fontWeight: FontWeight.w700),
    );
  }
}
