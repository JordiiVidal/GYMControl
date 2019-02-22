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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Exercice> list = [
    Exercice(
        name: 'Press de banca',
        weight: 45,
        start: false,
        series: 4,
        actualSeries: 0,
        recoveryTime: false,
        repetitions: 12,
        icon: Icon(Icons.play_arrow, size: 40.0)),
    Exercice(
        name: 'Press de banca',
        weight: 45,
        start: false,
        series: 4,
        actualSeries: 0,
        recoveryTime: false,
        repetitions: 12,
        icon: Icon(Icons.play_arrow, size: 40.0)),
    Exercice(
        name: 'Press de banca',
        weight: 45,
        start: false,
        series: 4,
        actualSeries: 0,
        recoveryTime: false,
        repetitions: 12,
        icon: Icon(Icons.play_arrow, size: 40.0)),
    Exercice(
        name: 'Press de banca',
        weight: 45,
        start: false,
        series: 4,
        actualSeries: 0,
        recoveryTime: false,
        repetitions: 12,
        icon: Icon(Icons.play_arrow, size: 40.0)),
    Exercice(
        name: 'Press de banca',
        weight: 45,
        start: false,
        series: 4,
        actualSeries: 0,
        recoveryTime: false,
        repetitions: 12,
        icon: Icon(Icons.play_arrow, size: 40.0)),
    Exercice(
        name: 'Press de banca',
        weight: 45,
        start: false,
        series: 4,
        actualSeries: 0,
        recoveryTime: false,
        repetitions: 12,
        icon: Icon(Icons.play_arrow, size: 40.0)),
    Exercice(
        name: 'Press de banca',
        weight: 45,
        start: false,
        series: 4,
        actualSeries: 0,
        recoveryTime: false,
        repetitions: 12,
        icon: Icon(Icons.play_arrow, size: 40.0)),
    Exercice(
        name: 'Press de banca',
        weight: 45,
        start: false,
        series: 4,
        actualSeries: 0,
        recoveryTime: false,
        repetitions: 12,
        icon: Icon(Icons.play_arrow, size: 40.0)),
    Exercice(
        name: 'Press de banca',
        weight: 45,
        start: false,
        series: 4,
        actualSeries: 0,
        recoveryTime: false,
        repetitions: 12,
        icon: Icon(Icons.play_arrow, size: 40.0)),
    Exercice(
        name: 'Press de banca',
        weight: 45,
        start: false,
        series: 4,
        actualSeries: 0,
        recoveryTime: false,
        repetitions: 12,
        icon: Icon(Icons.play_arrow, size: 40.0))
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
              list[index].actualSeries.toString() +
                  ' / ' +
                  list[index].series.toString(),
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                list[index].aumentarSeries();
              });
            },
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

  Widget _itemList(BuildContext context, int index) {
    return Container(
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
              onTap: () {
                _showModalSheet(context, index);
              },
              leading: FlatButton(
                child: list[index].icon,
                onPressed: () {
                  print('click');
                  if (list[index].start) {
                    setState(() {
                      list[index].start = false;
                      list[index].icon = Icon(
                        Icons.play_arrow,
                        size: 40.0,
                      );
                    });
                  } else {
                    setState(() {
                      list[index].start = true;
                      list[index].icon = Icon(
                        Icons.stop,
                        size: 40.0,
                      );
                    });
                  }
                },
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    list[index].repetitions.toString(),
                    style: TextStyle(fontSize: 21.0),
                  ),
                  Text(
                    'rep',
                    style: TextStyle(fontSize: 10.0),
                  )
                ],
              ),
              title: Text(list[index].name),
              trailing: GestureDetector(
                onTap: () {
                  setState(() {
                    list[index].weight = list[index].weight + 2;
                  });
                },
                onLongPress: () {
                  setState(() {
                    list[index].weight = 0;
                  });
                },
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        list[index].weight.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'kg',
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                    ],
                  ),
                  radius: 30.0,
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
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: _itemList,
        scrollDirection: Axis.vertical,
        itemCount: list.length,
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
