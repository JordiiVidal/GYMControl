import 'package:flutter/material.dart';
import 'models/exercice.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  Icon _icon = Icon(
    Icons.play_arrow,
    size: 45.0,
  );
  int _kilos = 0;
  bool state = false;

  Widget _containerStart() {
    return Container(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      color: Theme.of(context).accentColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 40.0,
            child: Text(
              '00.00',
              style: TextStyle(color: Colors.black, fontSize: 20.0),
            ),
          ),
          Container(
            child: Text(
              '0 / 3',
              style: TextStyle(color: Colors.white, fontSize: 17.0),
            ),
          ),
          FloatingActionButton(
            onPressed: () => {},
            backgroundColor: Colors.grey[200],
            child: Text(
              '+1',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[200],
                border: BorderDirectional(
                  top: BorderSide(
                    color: Colors.grey[300],
                    width: 1.0,
                  ),
                  bottom: BorderSide(
                    color: Colors.grey[300],
                    width: 1.0,
                  ),
                )),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: ListTile(
                  leading: FlatButton(
                    child: _icon,
                    onPressed: () {
                      if (state) {
                        setState(() {
                          state = false;
                          _icon = Icon(
                            Icons.play_arrow,
                            size: 45.0,
                          );
                        });
                      } else {
                        setState(() {
                          state = true;
                          _icon = Icon(
                            Icons.stop,
                            size: 45.0,
                          );
                        });
                      }
                    },
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Repeticiones'),
                      Text('Series'),
                      Text('tiempo')
                    ],
                  ),
                  title: Text('Nombre'),
                  trailing: GestureDetector(
                    onHorizontalDragDown: (DragDownDetails detail) {
                      print(detail);
                    },
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        '$_kilos kg',
                        style: TextStyle(color: Colors.white),
                      ),
                      radius: 30.0,
                    ),
                  ),
                ),
                ),
                state ? _containerStart() : Container()
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
