// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clan_of_pets/app/utils/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

import '../module/home/widget/common_grey_widget.dart';
import '../utils/app_constants.dart';
import '../utils/app_router.dart';
import '../utils/extensions.dart';
import 'size_box.dart';

class CommonInkwell extends StatelessWidget {
  final Widget child;
  final void Function()? onTap;
  final double? borderRadius;
  final Color? splashColor;
  const CommonInkwell(
      {super.key,
      required this.child,
      required this.onTap,
      this.borderRadius,
      this.splashColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      splashColor: splashColor ?? Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      focusColor: Colors.transparent,
      onTap: onTap,
      child: child,
    );
  }
}

class commonTextWidget extends StatelessWidget {
  final Color color;
  final String text;
  final double fontSize;
  final TextAlign align;
  final double letterSpacing;
  final FontWeight fontWeight;
  final int? maxLines;
  final double? height;
  final double? wordSpacing;
  final TextOverflow? overFlow;

  const commonTextWidget({
    super.key,
    required this.color,
    required this.text,
    this.fontSize = 18,
    this.fontWeight = FontWeight.normal,
    this.letterSpacing = 0.5,
    this.maxLines,
    this.align = TextAlign.center,
    this.overFlow,
    this.height,
    this.wordSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxLines,
      text,
      textAlign: align,
      style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontFamily: GoogleFonts.roboto().fontFamily,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          overflow: overFlow,
          wordSpacing: wordSpacing,
          height: height),
    );
  }
}

class CommonButton extends StatelessWidget {
  final void Function() onTap;
  final Color bgColor;
  final Color textColor;
  final String text;
  final double width;
  final Color borderColor;
  final double height;
  final double size;
  final bool isFullRoundedButton;
  final bool isIconShow;
  final bool isFromLogout;
  final double radius;

  const CommonButton({
    super.key,
    required this.onTap,
    this.bgColor = AppConstants.appPrimaryColor,
    this.textColor = AppConstants.white,
    this.borderColor = AppConstants.transparent,
    required this.text,
    required this.width,
    this.size = 18,
    this.isFullRoundedButton = false,
    this.isIconShow = false,
    required this.height,
    this.isFromLogout = false,
    this.radius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        // padding: const EdgeInsets.symmetric(vertical: 15),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: isFullRoundedButton
              ? BorderRadius.circular(100)
              : BorderRadius.circular(radius),
          color: bgColor,
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: isIconShow
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isFromLogout
                        ? Image.asset(
                            AppImages.settingsLogout,
                            height: 20,
                          )
                        : const Icon(
                            Icons.add,
                            size: 18,
                            color: AppConstants.appPrimaryColor,
                          ),
                    const SizeBoxV(6),
                    commonTextWidget(
                      color: textColor,
                      text: text,
                      fontWeight: FontWeight.w700,
                      fontSize: size,
                    ),
                  ],
                )
              : commonTextWidget(
                  color: textColor,
                  text: text,
                  fontWeight: FontWeight.w700,
                  fontSize: size,
                ),
        ),
      ),
    );
  }
}

class CommonButtonWithIcon extends StatelessWidget {
  final void Function() onTap;
  final Color bgColor;
  final Color textColor;
  final String text;
  final double width;
  final Color borderColor;
  final double height;
  final double size;
  final bool isFullRoundedButton;
  final String? imageIcon;
  final Color iconColor;
  final double? iconWidth;
  final double? iconHeight;
  final FontWeight fontWeight;
  final bool? isIcon;
  final Icon? icon;

  const CommonButtonWithIcon({
    super.key,
    required this.onTap,
    this.bgColor = AppConstants.appPrimaryColor,
    this.textColor = AppConstants.white,
    this.borderColor = AppConstants.transparent,
    required this.text,
    required this.width,
    this.size = 18,
    this.isFullRoundedButton = false,
    this.iconColor = AppConstants.white,
    this.iconHeight = 12,
    this.iconWidth = 8,
    this.imageIcon,
    this.fontWeight = FontWeight.w700,
    required this.height,
    this.isIcon,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CommonInkwell(
      onTap: onTap,
      child: Container(
        // padding: const EdgeInsets.symmetric(vertical: 15),
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: isFullRoundedButton
              ? BorderRadius.circular(100)
              : BorderRadius.circular(10),
          color: bgColor,
          border: Border.all(color: borderColor),
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            commonTextWidget(
              color: textColor,
              text: text,
              fontWeight: fontWeight,
              fontSize: size,
            ),
            const SizeBoxV(8),
            isIcon == true
                ? icon ?? const Icon(Icons.add)
                : Image.asset(
                    imageIcon ?? '',
                    color: iconColor,
                    height: iconHeight,
                    width: iconWidth,
                  )
          ],
        )),
      ),
    );
  }
}

class CommonTextFormField extends StatelessWidget {
  final Color bgColor;
  final String hintText;
  final Color hintTextColor;
  final Widget? prefixIcon;
  final Color color;

  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final int? maxLength;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final bool enabled;
  final bool readOnly;
  final double radius;
  final int? minLine;
  final int? maxLine;
  final FocusNode? focusNode;
  final bool isFromChat;
  final void Function(String)? onChanged;

  const CommonTextFormField({
    super.key,
    required this.bgColor,
    required this.hintText,
    this.hintTextColor = AppConstants.textFieldTextColor,
    this.color = AppConstants.black,
    required this.keyboardType,
    required this.textInputAction,
    this.validator,
    this.maxLength,
    required this.controller,
    this.contentPadding = const EdgeInsets.only(left: 10),
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.focusNode,
    this.enabled = true,
    this.readOnly = false,
    this.radius = 100,
    this.minLine,
    this.maxLine,
    this.isFromChat = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      onTap: onTap,
      style: TextStyle(
        color: color,
        fontSize: 12,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      textInputAction: textInputAction,
      enabled: enabled,
      focusNode: focusNode,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        counterText: '',
        contentPadding: contentPadding,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: isFromChat
              ? BorderSide.none
              : const BorderSide(
                  color: AppConstants.black10,
                ),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        suffixIcon: suffixIcon,
        fillColor: bgColor,
        filled: true,
        labelText: hintText,
        labelStyle: const TextStyle(
          color: AppConstants.black40,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
      validator: validator,
      maxLength: maxLength,
      controller: controller,
      readOnly: readOnly,
      minLines: minLine,
      maxLines: maxLine,
    );
  }
}

class commonNetworkImage extends StatelessWidget {
  final String url;
  final double height;
  final double width;
  final bool isTopCurved;
  final bool isBottomCurved;
  final BorderRadiusGeometry? borderRadius;
  final bool? isBorder;
  final double radius;
  final bool? isRound;

  const commonNetworkImage({
    super.key,
    required this.url,
    required this.height,
    required this.width,
    this.isTopCurved = true,
    this.isBottomCurved = true,
    this.borderRadius,
    this.isBorder,
    this.radius = 10,
    this.isRound = false,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            shape: isRound == true ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isRound == true
                ? null
                : isTopCurved
                    ? BorderRadius.circular(radius)
                    : isBottomCurved
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          )
                        : isBorder == true
                            ? borderRadius
                            // : const BorderRadius.only(
                            //     bottomLeft: Radius.circular(0),
                            //     bottomRight: Radius.circular(0),
                            //   ),
                            : const BorderRadius.only(
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0),
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      placeholder: (context, url) => SizedBox(
        height: height,
        width: width,
        child: const Center(
          child: CircularProgressIndicator(
            color: AppConstants.appPrimaryColor,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          shape: isRound == true ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isRound == true
              ? null
              : isTopCurved
                  ? BorderRadius.circular(radius)
                  : isBottomCurved
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )
                      : isBorder == true
                          ? borderRadius
                          : const BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
          image: DecorationImage(
            image: AssetImage(
              AppImages.errorImaage,
            ),
            fit: BoxFit.cover,
          ),
        ),
        height: height,
        width: width,
      ),
    );
  }
}

bool _isToastShowing = false;

void toast(
  BuildContext context, {
  String? title,
  int duration = 2,
  Color? backgroundColor,
}) {
  if (_isToastShowing) return;

  _isToastShowing = true;

  final scaffold = ScaffoldMessenger.of(context);
  scaffold
      .showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          duration: Duration(seconds: duration),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          width: Responsive.width * 90,
          content: Container(
            height: Responsive.height * 3,
            alignment: Alignment.center,
            child: Text(
              title ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: backgroundColor == const Color(0xFFFFDD11)
                      ? AppConstants.black
                      : Colors.white),
            ),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      )
      .closed
      .then((reason) {
    _isToastShowing = false;
  });
}

class InnerShadow extends SingleChildRenderObjectWidget {
  const InnerShadow({
    super.key,
    this.blur = 10,
    this.color = Colors.black38,
    this.offset = const Offset(10, 10),
    required Widget super.child,
  });

  final double blur;
  final Color color;
  final Offset offset;

  @override
  RenderObject createRenderObject(BuildContext context) {
    final _RenderInnerShadow renderObject = _RenderInnerShadow();
    updateRenderObject(context, renderObject);
    return renderObject;
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderInnerShadow renderObject) {
    renderObject
      ..color = color
      ..blur = blur
      ..dx = offset.dx
      ..dy = offset.dy;
  }
}

class _RenderInnerShadow extends RenderProxyBox {
  double? blur;
  Color? color;
  double? dx;
  double? dy;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;

    final Rect rectOuter = offset & size;
    final Rect rectInner = Rect.fromLTWH(
      offset.dx,
      offset.dy,
      size.width - dx!,
      size.height - dy!,
    );
    final Canvas canvas = context.canvas..saveLayer(rectOuter, Paint());
    context.paintChild(child!, offset);
    final Paint shadowPaint = Paint()
      ..blendMode = BlendMode.srcATop
      ..imageFilter = ImageFilter.blur(sigmaX: blur ?? 0, sigmaY: blur ?? 0)
      ..colorFilter =
          ColorFilter.mode(color ?? Colors.transparent, BlendMode.srcOut);

    canvas
      ..saveLayer(rectOuter, shadowPaint)
      ..saveLayer(rectInner, Paint())
      ..translate(dx ?? 0, dy ?? 0);
    context.paintChild(child!, offset);
    context.canvas
      ..restore()
      ..restore()
      ..restore();
  }
}

class CommonAppBarWidgets extends StatelessWidget {
  final String? text;
  const CommonAppBarWidgets({this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          commonTextWidget(
            text: text ?? "Expenses",
            color: AppConstants.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          CommonGreyContainer(
            borderRadius: BorderRadius.circular(100),
            height: 30,
            width: 30,
            image: AppImages.bellIcon,
            imageHeight: 12,
          ),
        ],
      ),
      leading: IconButton(
        onPressed: () {
          Routes.back(context: context);
        },
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            AppConstants.greyContainerBg,
          ),
        ),
        icon: const Icon(
          Icons.arrow_back_ios_new,
          size: 19,
          color: AppConstants.appPrimaryColor,
        ),
      ),
    );
  }
}
