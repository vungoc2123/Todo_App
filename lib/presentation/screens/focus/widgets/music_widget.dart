import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/constants/app_text_style.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/screens/focus/bloc/focus_cubit.dart';
import 'package:todo/presentation/screens/focus/bloc/focus_state.dart';

class Sound {
  final String name;
  final String url;

  Sound({required this.name, required this.url});
}

class MusicWidget extends StatefulWidget {
  const MusicWidget({super.key});

  @override
  State<MusicWidget> createState() => _MusicWidgetState();
}

class _MusicWidgetState extends State<MusicWidget> {
  final List<Sound> listSound = [
    Sound(name: 'Không có', url: ''),
    Sound(name: 'Suối chảy', url: Assets.music.suoichay),
    Sound(name: 'Mưa rơi', url: Assets.music.muaroi),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r))),
      child: Column(
        children: [
          Text(
            tr("chooseSound"),
            style: AppTextStyle.textXl,
          ),
          SizedBox(
            height: 16.h,
          ),
          BlocBuilder<FocusCubit, FocusState>(
            buildWhen: (previous, current) => previous.sound != current.sound,
            builder: (BuildContext context, state) {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: listSound.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      BlocProvider.of<FocusCubit>(context)
                          .chooseSound(listSound[index].url);
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20.w,
                          child: state.sound == listSound[index].url
                              ? const Icon(Icons.done)
                              : null,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(
                          listSound[index].name,
                          style: AppTextStyle.textBase,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  height: 12.h,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
