import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/application/constants/app_colors.dart';

class CustomLabelTextField extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? defaultValue;
  final Color? backgroundColor;
  final Color? colorBorder;
  final double? radius;
  final Function(String value)? onChanged;
  final int? maxLine;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool isRequired;
  final bool enable;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? textStyleLabel;
  final TextStyle? textStyleError;
  final TextStyle? textStyleHint;
  final String? errorMessage;

  const CustomLabelTextField({
    super.key,
    this.label,
    this.defaultValue = "",
    this.backgroundColor,
    this.colorBorder,
    this.radius,
    this.hintText,
    this.onChanged,
    this.maxLength,
    this.maxLine,
    this.keyboardType,
    this.isRequired = false,
    this.enable = true,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.textStyleLabel,
    this.textStyleError,
    this.textStyleHint,
    this.errorMessage,
  });

  @override
  State<CustomLabelTextField> createState() => _CustomLabelTextFieldState();
}

class _CustomLabelTextFieldState extends State<CustomLabelTextField> {
  late TextEditingController _controller;
  late double _radius;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.defaultValue);
    _radius = widget.radius ?? 8.r;

    _controller.addListener(() {
      widget.onChanged?.call(_controller.text);
    });
  }

  Color handleColor() {
    return widget.errorMessage?.isNotEmpty == true
        ? Colors.red
        : AppColors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Text(
              widget.label ?? "",
              style: widget.textStyleLabel,
            ),
          SizedBox(height: 8.h),
          TextFormField(
            textAlignVertical: TextAlignVertical.center,
            controller: _controller,
            maxLength: widget.maxLength,
            obscuringCharacter: "•",
            maxLines: widget.obscureText ? 1 : widget.maxLine,
            enabled: widget.enable,
            obscureText: widget.obscureText,
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              filled: true,
              fillColor: widget.backgroundColor ?? Colors.transparent,
              counter: const Offstage(),
              contentPadding: EdgeInsets.only(
                  left: 15.w, right: 15.w, top: 15.h, bottom: 15.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(_radius),
                borderSide: BorderSide(
                  color: widget.colorBorder ?? handleColor(),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: handleColor()),
                  borderRadius: BorderRadius.circular(_radius)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide( color: widget.colorBorder?? handleColor()),
                  borderRadius: BorderRadius.circular(_radius)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(_radius)),
              hintText: widget.hintText,
              hintStyle: GoogleFonts.inter(
                fontSize: widget.textStyleHint?.fontSize ?? 16.sp,
                fontWeight: widget.textStyleHint?.fontWeight ?? FontWeight.w400,
                color: widget.textStyleHint?.color ?? Colors.grey,
              ),
              suffixIcon: widget.suffixIcon != null
                  ? Padding(
                  padding: EdgeInsets.only(left: 8.w, right: 10.w),
                  child: widget.suffixIcon)
                  : null,
              suffixIconConstraints: BoxConstraints(maxWidth: 38.w),
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 8.w),
                  child: widget.prefixIcon)
                  : null,
              prefixIconConstraints: BoxConstraints(maxWidth: 38.w),
              isDense: true,
            ),
            keyboardType: widget.keyboardType,
            style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary),
          ),
          if (widget.errorMessage?.isNotEmpty == true)
            Text(
              widget.errorMessage!,
              style: widget.textStyleError ??
                  GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.red,
                  ),
            )
        ],
      ),
    );
  }
}
