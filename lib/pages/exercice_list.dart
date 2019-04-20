import 'package:flutter/material.dart';
import '../tools/text.dart';
import '../models/exercice.dart';
import '../widgets/helpers/models.dart';
import '../widgets/exercice/recovery_time.dart';

class ExerciceListPage extends StatefulWidget {
  final List<Exercice> list;

  ExerciceListPage(this.list);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExerciceListPageState();
  }
}

class _ExerciceListPageState extends State<ExerciceListPage>
    with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AnimationController controller;

  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 180));
  }

  Widget _containerStart(int index) {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
      decoration: BoxDecoration(
          border: BorderDirectional(
              top: BorderSide(color: Colors.grey[100], width: 2.0))),
      child: RecoveryTime(widget.list, index, controller),
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
              modalImageExercice(context, index, widget.list);
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
                      if (widget.list[index].start) {
                        if (mounted) {
                          setState(() {
                            widget.list[index].start = false;
                          });
                        }
                      } else {
                        setState(() {
                          widget.list[index].start = true;
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
                      TextSpan(text: widget.list[index].series.toString()),
                      TextSpan(
                        text: ' series ',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0,
                            color: Colors.grey[700]),
                      ),
                      TextSpan(text: widget.list[index].repetitions.toString()),
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
                widget.list[index].name,
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
                      text: weightNumber(widget.list[index].weight),
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
          widget.list[index].start ? _containerStart(index) : Container()
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
        itemCount: widget.list.length,
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