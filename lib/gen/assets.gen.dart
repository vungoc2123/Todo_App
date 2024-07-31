/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

class $AssetsAnimationIconGen {
  const $AssetsAnimationIconGen();

  /// File path: assets/animation_icon/loading.json
  String get loading => 'assets/animation_icon/loading.json';

  /// List of all assets
  List<String> get values => [loading];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/account.svg
  SvgGenImage get account => const SvgGenImage('assets/icons/account.svg');

  /// File path: assets/icons/apple.svg
  SvgGenImage get apple => const SvgGenImage('assets/icons/apple.svg');

  /// File path: assets/icons/binoculars.svg
  SvgGenImage get binoculars =>
      const SvgGenImage('assets/icons/binoculars.svg');

  /// File path: assets/icons/building.svg
  SvgGenImage get building => const SvgGenImage('assets/icons/building.svg');

  /// File path: assets/icons/eye-crossed.svg
  SvgGenImage get eyeCrossed =>
      const SvgGenImage('assets/icons/eye-crossed.svg');

  /// File path: assets/icons/eye.svg
  SvgGenImage get eye => const SvgGenImage('assets/icons/eye.svg');

  /// File path: assets/icons/frame.svg
  SvgGenImage get frame => const SvgGenImage('assets/icons/frame.svg');

  /// File path: assets/icons/gmail.png
  AssetGenImage get gmail => const AssetGenImage('assets/icons/gmail.png');

  /// File path: assets/icons/google.png
  AssetGenImage get google => const AssetGenImage('assets/icons/google.png');

  /// File path: assets/icons/home.svg
  SvgGenImage get home => const SvgGenImage('assets/icons/home.svg');

  /// File path: assets/icons/icon_calendar.svg
  SvgGenImage get iconCalendar =>
      const SvgGenImage('assets/icons/icon_calendar.svg');

  /// File path: assets/icons/icon_checkbox.svg
  SvgGenImage get iconCheckbox =>
      const SvgGenImage('assets/icons/icon_checkbox.svg');

  /// File path: assets/icons/icon_clock_three.svg
  SvgGenImage get iconClockThree =>
      const SvgGenImage('assets/icons/icon_clock_three.svg');

  /// File path: assets/icons/icon_close.svg
  SvgGenImage get iconClose => const SvgGenImage('assets/icons/icon_close.svg');

  /// File path: assets/icons/icon_delete.svg
  SvgGenImage get iconDelete =>
      const SvgGenImage('assets/icons/icon_delete.svg');

  /// File path: assets/icons/icon_edit.svg
  SvgGenImage get iconEdit => const SvgGenImage('assets/icons/icon_edit.svg');

  /// File path: assets/icons/plus.svg
  SvgGenImage get plus => const SvgGenImage('assets/icons/plus.svg');

  /// List of all assets
  List<dynamic> get values => [
        account,
        apple,
        binoculars,
        building,
        eyeCrossed,
        eye,
        frame,
        gmail,
        google,
        home,
        iconCalendar,
        iconCheckbox,
        iconClockThree,
        iconClose,
        iconDelete,
        iconEdit,
        plus
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/.getKeep
  String get aGetKeep => 'assets/images/.getKeep';

  /// File path: assets/images/planning.png
  AssetGenImage get planning =>
      const AssetGenImage('assets/images/planning.png');

  /// List of all assets
  List<dynamic> get values => [aGetKeep, planning];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/en-US.json
  String get enUS => 'assets/translations/en-US.json';

  /// File path: assets/translations/vi-VN.json
  String get viVN => 'assets/translations/vi-VN.json';

  /// List of all assets
  List<String> get values => [enUS, viVN];
}

class Assets {
  Assets._();

  static const $AssetsAnimationIconGen animationIcon =
      $AssetsAnimationIconGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = false;

  const SvgGenImage.vec(
    this._assetName, {
    this.size,
    this.flavors = const {},
  }) : _isVecFormat = true;

  final String _assetName;
  final Size? size;
  final Set<String> flavors;
  final bool _isVecFormat;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    final BytesLoader loader;
    if (_isVecFormat) {
      loader = AssetBytesLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
      );
    } else {
      loader = SvgAssetLoader(
        _assetName,
        assetBundle: bundle,
        packageName: package,
        theme: theme,
      );
    }
    return SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter ??
          (color == null ? null : ColorFilter.mode(color, colorBlendMode)),
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
