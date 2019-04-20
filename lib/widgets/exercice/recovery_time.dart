import 'package:flutter/material.dart';
import 'package:gymcontrol/models/timer.dart';

class RecoveryTime extends StatelessWidget{

  final AnimationController controller;
  final String timerString;

  RecoveryTime(this.controller,this.timerString);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 180.0,
      child: Align(
        alignment: FractionalOffset.center,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: GestureDetector(
            onTap: () {
              if (controller.isAnimating) {
                controller.stop();
              } else {
                controller.reverse(
                    from: controller.value == 0.0 ? 1.0 : controller.value);
              }
            },
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: AnimatedBuilder(
                    animation: controller,
                    builder: (BuildContext context, Widget child) {
                      return CustomPaint(
                        painter: TimerPainter(
                          animation: controller,
                          backgroundColor: Colors.grey[200],
                          color: Color(0xffDB274A),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: FractionalOffset.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      AnimatedBuilder(
                        animation: controller,
                        builder: (BuildContext context, Widget child) {
                          return Text(
                            timerString,
                            style: TextStyle(
                                fontSize: 50.0, fontWeight: FontWeight.w200),
                          );
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );;
  }
}