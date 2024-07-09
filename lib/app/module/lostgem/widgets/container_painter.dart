import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.2127660, size.height * 0.2767692);
    path_0.cubicTo(size.width * 0.2127660, size.height * 0.1239142,
        size.width * 0.1908490, 0, size.width * 0.1638133, 0);
    path_0.lineTo(0, 0);
    path_0.lineTo(size.width * 0.9319728, 0);
    path_0.cubicTo(size.width * 0.9695442, 0, size.width,
        size.height * 0.1721983, size.width, size.height * 0.3846154);
    path_0.lineTo(size.width, size.height * 0.3846154);
    path_0.lineTo(size.width, size.height * 0.8653846);
    path_0.lineTo(size.width * 0.9954354, size.height * 0.8175135);
    path_0.cubicTo(
        size.width * 0.9788231,
        size.height * 0.6432654,
        size.width * 0.9455272,
        size.height * 0.5412462,
        size.width * 0.9106395,
        size.height * 0.5576923);
    path_0.lineTo(size.width * 0.9106395, size.height * 0.5576923);
    path_0.lineTo(size.width * 0.8638299, size.height * 0.5576923);
    path_0.lineTo(size.width * 0.8063844, size.height * 0.5576923);
    path_0.lineTo(size.width * 0.5085102, size.height * 0.5576923);
    path_0.lineTo(size.width * 0.2680850, size.height * 0.5576923);
    path_0.lineTo(size.width * 0.2574959, size.height * 0.5525077);
    path_0.cubicTo(
        size.width * 0.2321915,
        size.height * 0.5401212,
        size.width * 0.2127660,
        size.height * 0.4203731,
        size.width * 0.2127660,
        size.height * 0.2767692);
    path_0.lineTo(size.width * 0.2127660, size.height * 0.2767692);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.2382980, size.height * 0.2346942);
    path_1.cubicTo(size.width * 0.2382980, size.height * 0.1050762,
        size.width * 0.2197129, 0, size.width * 0.1967874, 0);
    path_1.lineTo(size.width * 0.04680850, 0);
    path_1.lineTo(size.width * 0.9319728, 0);
    path_1.cubicTo(size.width * 0.9695442, 0, size.width,
        size.height * 0.1721983, size.width, size.height * 0.3846154);
    path_1.lineTo(size.width, size.height * 0.6860288);
    path_1.lineTo(size.width, size.height * 0.6860288);
    path_1.cubicTo(
        size.width * 0.9840510,
        size.height * 0.5506885,
        size.width * 0.9571871,
        size.height * 0.4693885,
        size.width * 0.9284252,
        size.height * 0.4693885);
    path_1.lineTo(size.width * 0.7553197, size.height * 0.4693885);
    path_1.lineTo(size.width * 0.2798082, size.height * 0.4693885);
    path_1.cubicTo(
        size.width * 0.2568827,
        size.height * 0.4693885,
        size.width * 0.2382980,
        size.height * 0.3643115,
        size.width * 0.2382980,
        size.height * 0.2346942);
    path_1.lineTo(size.width * 0.2382980, size.height * 0.2346942);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = const Color(0xffF5895A).withOpacity(1.0);
    canvas.drawPath(path_1, paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// import 'dart:ui' as ui;

class RPSCustomPainterWhite extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.2127660, size.height * 0.2767731);
    path_0.cubicTo(
        size.width * 0.2127660,
        size.height * 0.1239165,
        size.width * 0.1908490,
        size.height * 0.000002347500,
        size.width * 0.1638133,
        size.height * 0.000002347500);
    path_0.lineTo(0, size.height * 0.000002347500);
    path_0.lineTo(size.width * 0.9319728, size.height * 0.000002347500);
    path_0.cubicTo(
        size.width * 0.9695442,
        size.height * 0.000002347500,
        size.width,
        size.height * 0.1722006,
        size.width,
        size.height * 0.3846173);
    path_0.lineTo(size.width, size.height * 0.3846173);
    path_0.lineTo(size.width, size.height * 0.8653865);
    path_0.lineTo(size.width * 0.9954354, size.height * 0.8175154);
    path_0.cubicTo(
        size.width * 0.9788231,
        size.height * 0.6432692,
        size.width * 0.9455272,
        size.height * 0.5412481,
        size.width * 0.9106395,
        size.height * 0.5576942);
    path_0.lineTo(size.width * 0.9106395, size.height * 0.5576942);
    path_0.lineTo(size.width * 0.8638299, size.height * 0.5576942);
    path_0.lineTo(size.width * 0.8063844, size.height * 0.5576942);
    path_0.lineTo(size.width * 0.5085102, size.height * 0.5576942);
    path_0.lineTo(size.width * 0.2680850, size.height * 0.5576942);
    path_0.lineTo(size.width * 0.2574959, size.height * 0.5525115);
    path_0.cubicTo(
        size.width * 0.2321915,
        size.height * 0.5401231,
        size.width * 0.2127660,
        size.height * 0.4203750,
        size.width * 0.2127660,
        size.height * 0.2767731);
    path_0.lineTo(size.width * 0.2127660, size.height * 0.2767731);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.white.withOpacity(1.0);
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
