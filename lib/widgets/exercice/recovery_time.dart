import 'package:flutter/material.dart';
import 'package:gymcontrol/models/timer.dart';
import '../../models/exercice.dart';


class RecoveryTime extends StatefulWidget {

  final List<Exercice> list;
  final int index;
  AnimationController controller;

  RecoveryTime(this.list,this.index,this.controller);
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RecoveryTimeState();
  }
}

class _RecoveryTimeState extends State<RecoveryTime>
     {

  String get timerString {
    Duration duration = widget.controller.duration * widget.controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Container(
          height: 180.0,
          child: Align(
            alignment: FractionalOffset.center,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: GestureDetector(
                onTap: () {
                  if (widget.controller.isAnimating) {
                    widget.controller.stop();
                  } else {
                    widget.controller.reverse(
                        from: widget.controller.value == 0.0 ? 1.0 : widget.controller.value);
                  }
                },
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: AnimatedBuilder(
                        animation: widget.controller,
                        builder: (BuildContext context, Widget child) {
                          return CustomPaint(
                            painter: TimerPainter(
                              animation: widget.controller,
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
                            animation: widget.controller,
                            builder: (BuildContext context, Widget child) {
                              return Text(
                                timerString,
                                style: TextStyle(
                                    fontSize: 50.0,
                                    fontWeight: FontWeight.w200),
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
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Tiempo Descanso',
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child: Text(
                widget.list[widget.index].actualSeries.toString() +
                    ' / ' +
                    widget.list[widget.index].series.toString(),
                style: TextStyle(color: Colors.black, fontSize: 30.0),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  widget.list[widget.index].increaseSeries();
                  widget.controller.reset();
                  widget.controller.reverse(
                      from: widget.controller.value == 0.0 ? 1.0 : widget.controller.value);
                });
              },
              backgroundColor: Color(0xffDB274A),
              child: Text(
                '+1',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.0,
                    fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Serie Actual',
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300),
              ),
              Text(
                'Aumentar Serie',
                style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
