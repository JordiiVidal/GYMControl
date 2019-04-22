import 'package:flutter/material.dart';
import 'dart:math' as math;

class ExerciceFAB extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExerciceFABState();
  }
}

class _ExerciceFABState extends State<ExerciceFAB>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 56.0,
          height: 60.0,
          alignment: FractionalOffset.topCenter,
          child: ScaleTransition(
            scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 1.0, curve: Curves.easeOut)),
            child: FloatingActionButton(
              backgroundColor: Colors.grey[50],
              heroTag: 'addFAB',
              mini: true,
              onPressed: () {
                Navigator.pushNamed(context, '/create');
              },
              child: Icon(
                Icons.add,
                color: Color(0xffDB274A),
              ),
            ),
          ),
        ),
        Container(
          width: 56.0,
          height: 60.0,
          alignment: FractionalOffset.topCenter,
          child: ScaleTransition(
            scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 0.5, curve: Curves.easeOut)),
            child: FloatingActionButton(
              backgroundColor: Colors.grey[50],
              heroTag: 'finishFAB',
              mini: true,
              onPressed: () {},
              child: Icon(
                Icons.fitness_center,
                color: Color(0xffDB274A),
              ),
            ),
          ),
        ),
        Container(
          child: FloatingActionButton(
            backgroundColor: Color(0xffDB274A),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return Transform(
                  alignment: FractionalOffset.center,
                  transform:
                      Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                  child: Icon(
                      _controller.isDismissed ? Icons.more_vert : Icons.close),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
