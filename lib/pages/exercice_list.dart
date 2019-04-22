import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gymcontrol/database/DBHelper.dart';
import 'package:gymcontrol/models/exercice_db.dart';
import 'package:gymcontrol/widgets/exercice/exercicie_fab.dart';
import '../models/exercice.dart';
import '../widgets/helpers/models.dart';
import '../widgets/exercice/recovery_time.dart';

Future<List<ExerciceDB>> getExercicesFromDB() async {
  var dbHelper = DBHelper();
  Future<List<ExerciceDB>> exercices = dbHelper.getExercices();
  return exercices;
}

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
        AnimationController(vsync: this, duration: Duration(seconds: 60));
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

  Widget _itemList(
      BuildContext context, int index, List<ExerciceDB> snapshotList) {
    return Dismissible(
      key: Key(snapshotList[index].id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: EdgeInsets.only(right: 20.0),
        color: Colors.red[300],
        child: new Align(
          alignment: Alignment.centerRight,
          child: new Text('Eliminar',
              textAlign: TextAlign.right,
              style: new TextStyle(color: Colors.white)),
        ),
      ),
      onDismissed: (DismissDirection direction) {
        if (direction == DismissDirection.endToStart) {
          var dbHelper = DBHelper();
          dbHelper.deleteExercice(snapshotList[index]);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('Ejercicio Eliminado'),
            ),
          );
          snapshotList.remove(snapshotList[index]);
          setState(() {
            getExercicesFromDB();
          });
        }
      },
      child: Container(
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
              leading: FloatingActionButton(
                heroTag: 'btn$index',
                mini: true,
                backgroundColor: Color(0xffDB274A),
                child: new Image(
                  image: new AssetImage("assets/gym_07.png"),
                  width: 40.0,
                  height: 40.0,
                  color: null,
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomLeft,
                ),
                onPressed: () {
                  /*if (widget.list[index].start) {
                  setState(() {
                    widget.list[index].start = false;
                  });
                } else {
                  setState(() {
                    widget.list[index].start = true;
                  });
                }*/
                },
              ),
              subtitle: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 21.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        children: <TextSpan>[
                          TextSpan(text: snapshotList[index].series.toString()),
                          TextSpan(
                            text: ' series ',
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 14.0,
                                color: Colors.grey[700]),
                          ),
                          TextSpan(
                              text: snapshotList[index].repetitions.toString()),
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
              ),
              title: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
                child: Text(
                  snapshotList[index].name,
                  style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black54,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            //widget.list[index].start ? _containerStart(index) : Container()
          ],
        ),
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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person_pin,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/user');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<ExerciceDB>>(
        future: getExercicesFromDB(),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data.length == 0) {
              return Center(
                child: Text('No hay ejercicios'),
              );
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) =>
                    _itemList(context, index, snapshot.data),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.length,
              );
            }
          }
          return Container(
            alignment: AlignmentDirectional.center,
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: ExerciceFAB(),
    );
  }
}
