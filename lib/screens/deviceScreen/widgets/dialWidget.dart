import 'package:flutter/material.dart';
import 'dart:math';


class DialWidget extends StatefulWidget {
  final int value;

  const DialWidget({Key key, this.value}) : super(key: key);

  @override
  _DialWidgetState createState() => _DialWidgetState();
}

class _DialWidgetState extends State<DialWidget> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation<double> tweenAnimation;

  @override
  void initState() {
    super.initState();
    controller = new AnimationController(
      value: 0.0,		// the current value of the animation, usually 0.0 (= default)
      lowerBound:	0.0, // the lowest value of the animation, usually 0.0 (= default)
      upperBound:	1.0, // the highest value of the animation, usually 1.0 (= default)
      duration:	Duration(seconds: 4),// the total duration of the whole animation (scene)
      vsync: this,
    )..addListener((){
		  setState((){});
	  });
    tweenAnimation = new CurveTween(curve: Curves.fastLinearToSlowEaseIn).animate(controller);
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(child: CustomPaint(painter: DrawDial(context, widget.value * tweenAnimation.value))),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${(widget.value * tweenAnimation.value).round()}', 
                  style: TextStyle(
                    fontSize: 80.0, 
                    fontWeight: FontWeight.bold, 
                    color: Colors.redAccent.withOpacity(0.8)
                  ),
                ),
                Text('PPM',
                  style: TextStyle(
                    color: Colors.redAccent.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
  }

  @override
	void dispose(){
	  controller.dispose();
	  super.dispose();
	}

}


class DrawDial extends CustomPainter {
  Paint _borderPaint;
  Paint _dialPaint;
  Paint _dialValuePaint;
  Paint _pointPaint;

  final double value;

  final Map<String, double> angles = {'800': 0, '600': pi/4, '400':pi/2, '200':3*pi/4, '0':pi, '1400':5*pi/4, '1200':6*pi/4, '1000':7*pi/4};
  //[0, pi / 4, pi / 2, 3 * pi / 4, pi, 5 * pi / 4, 6 * pi / 4, 7 * pi / 4];
  
  Rect rect = new Rect.fromCircle(
    center: new Offset(0.0, 0.0),
    radius: 150.0,
  );

  Rect valueRect = new Rect.fromCircle(
    center: Offset(0.0, 0.0),
    radius: 140.0
  );

  DrawDial(BuildContext context, this.value) {
    final Gradient gradient = new LinearGradient(
      colors: <Color>[
        Colors.blueGrey,
        Theme.of(context).primaryColor,
      ],
      stops: [
        0.0,
        1.0
      ],
      tileMode: TileMode.mirror,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight
    );

    final Gradient dialValueGradient = new SweepGradient(
      startAngle:  0,
      endAngle: 4 * pi / 180,
      colors: <Color> [
        Colors.redAccent,
        Colors.transparent,
      ],
      stops: [
        3*pi / 90,
        3*pi / 90
      ],
      tileMode: TileMode.repeated
    );

    Gradient dialGradient = SweepGradient(
      startAngle: 0,
      endAngle: 4 * pi / 180,
      colors: <Color> [
        Colors.blueGrey,
        Colors.transparent,
        //Theme.of(context).primaryColor
      ],
      stops: [
        3 * pi / 90,
        3 * pi / 90
      ],
      tileMode: TileMode.repeated
    );

    _borderPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..strokeWidth = 25.0
      ..style = PaintingStyle.stroke;
    _dialValuePaint = Paint()
      ..shader = dialValueGradient.createShader(rect)
      ..strokeWidth = 15.0
      ..style = PaintingStyle.stroke;
    _dialPaint = Paint()
      ..shader = dialGradient.createShader(rect)
      ..strokeWidth = 15.0
      ..style = PaintingStyle.stroke;

    _pointPaint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;
  }

  Offset getTextPosition(x, y) {
    int rX = x.round(), rY = y.round();
    if(rX == 0) {
      if(rY == 120) {
        return Offset(-8, 100);
      } else if (rY == -120) {
        return Offset(-3, y+10);
      }
    } else if (rY == 0) {
      if(rX == 120) {
        return Offset(x - 35, y - 5);
      } else {
        return Offset(x + 10, y - 5);
      }
    }
    if(x < 0 && y < 0) {
      return Offset(x + 7, y + 5);
    } else if (x > 0 && y > 0) {
      return Offset(x - 30, y - 15);
    }
    return Offset(rX > 0 ? x - 25 : x + 10, rY > 0 ? y - 15 : y + 8);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), 170.0, _borderPaint);
    canvas.drawCircle(Offset(0.0, 0.0), 140.0, _dialPaint);
    canvas.drawArc(valueRect, 3 * pi / 2, 2 * pi * value/1600, false, _dialValuePaint);
    canvas.drawCircle(Offset(170 * sin(2 * pi * value/1600), -170 * cos(2 * pi * value/1600)), 2.0, _pointPaint);
    angles.forEach((index, angle) {
      double x = 120 * sin(angle), y = 120 * cos(angle);
      canvas.drawCircle(Offset(x, y), 2.0, _pointPaint);
      TextSpan span = new TextSpan(
          style: new TextStyle(color: Colors.grey, fontSize: 10.0,
          fontFamily: 'Roboto'), text: '$index');
      TextPainter tp = new TextPainter(
          text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(canvas, getTextPosition(x, y));
    });
    //drawNumbers(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}