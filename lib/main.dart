import 'package:flutter/material.dart';
import 'models/exercice.dart';
import 'dart:math' as math;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'GymControl',
      theme: new ThemeData(
          primaryColor: Colors.teal[800], accentColor: Colors.teal[700]),
      home: new MyHomePage(title: 'GymControl'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 180));
  }

  List<Exercice> list = [
    Exercice(
      name: 'Press de banca',
      weight: 45.0,
      start: false,
      series: 4,
      actualSeries: 0,
      recoveryTime: false,
      repetitions: 12,
    ),
    Exercice(
      name: 'Press de banca',
      weight: 32.0,
      start: false,
      series: 4,
      actualSeries: 0,
      recoveryTime: false,
      repetitions: 12,
    ),
  ];

  _showModalSheet(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 350.0,
            color: Theme.of(context).primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/gym_01.jpg',
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      list[index].name,
                      style: TextStyle(fontSize: 21.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _containerStart(int index) {
    return Container(
        padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
        decoration: BoxDecoration(
            border: BorderDirectional(
                top: BorderSide(color: Colors.grey[100], width: 2.0))),
        child: Column(
          children: <Widget>[
            timerExercice(),
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
                    list[index].actualSeries.toString() +
                        ' / ' +
                        list[index].series.toString(),
                    style: TextStyle(color: Colors.black, fontSize: 30.0),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      list[index].increaseSeries();
                      controller.reset();
                      controller.reverse(
                          from:
                              controller.value == 0.0 ? 1.0 : controller.value);
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
        ));
  }

  Widget timerExercice() {
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
    );
  }

  Widget _itemList(BuildContext context, int index) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            offset: Offset(1.0, 3.0),
            blurRadius: 5.0,
          ),
        ],
        color: Colors.white,
        border: BorderDirectional(
          bottom: BorderSide(
            color: Colors.grey[200],
            width: 1.0,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {
              _showModalSheet(context, index);
            },
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
                  child: FlatButton(
                    child: new Image(
                      image: new AssetImage("assets/gym_07.png"),
                      width: 40.0,
                      height: 40.0,
                      color: null,
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.bottomLeft,
                    ),
                    onPressed: () {
                      print('click');
                      if (list[index].start) {
                        setState(() {
                          list[index].start = false;
                        });
                      } else {
                        setState(() {
                          list[index].start = true;
                        });
                      }
                    },
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 21.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: list[index].series.toString()),
                      TextSpan(
                        text: ' series ',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0,
                            color: Colors.grey[700]),
                      ),
                      TextSpan(text: list[index].repetitions.toString()),
                      TextSpan(
                        text: ' rep',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0,
                            color: Colors.grey[700]),
                      ),
                    ],
                  ),
                )
              ],
            ),
            title: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
              child: Text(
                list[index].name,
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black54,
                    fontWeight: FontWeight.w300),
              ),
            ),
            trailing: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: BorderDirectional(
                    start: BorderSide(width: 1.0, color: Colors.grey[400])),
                color: Colors.white,
              ),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: list[index].weight.toString(),
                    ),
                    TextSpan(
                      text: ' kg',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 10.0,
                          color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
            ),
          ),
          list[index].start ? _containerStart(index) : Container()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xffDB274A),
        title: Text('GYMControl'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: _itemList,
        scrollDirection: Axis.vertical,
        itemCount: list.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: Color(0xffDB274A),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;

    double progress = (1.0 - animation.value) * 2 * math.pi;

    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
