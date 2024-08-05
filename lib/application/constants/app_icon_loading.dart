import 'package:todo/gen/assets.gen.dart';

class AppIconLoadingModel {
  final String title;
  final String path;

  const AppIconLoadingModel({required this.title, required this.path});
}

class MyAppIconLoading {
  static final loadingIcons = [
    Assets.animationIcon.loading,
    Assets.animationIcon.iconAnimation2,
    Assets.animationIcon.iconAnimation3,
    Assets.animationIcon.iconAnimation4,
  ];

  static final appIconLoadings = [
    AppIconLoadingModel(title: 'loading1', path: Assets.animationIcon.loading),
    AppIconLoadingModel(
        title: 'loading2', path: Assets.animationIcon.iconAnimation2),
    AppIconLoadingModel(
        title: 'loading3', path: Assets.animationIcon.iconAnimation3),
    AppIconLoadingModel(
        title: 'loading4', path: Assets.animationIcon.iconAnimation4),
  ];
}
