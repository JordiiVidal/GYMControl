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
        icon: Icon(Icons.fitness_center, size: 40.0)),
    Exercice(
        name: 'Press de banca',
        weight: 45,
        start: false,
        series: 4,
        actualSeries: 0,
        recoveryTime: false,
        repetitions: 12,
        icon: Icon(Icons.fitness_center, size: 40.0)),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(width: 2.0, color: Colors.grey[300])),
                  child: GestureDetector(
                    onTap: () {
                      print('Empezar descanso');
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: 50.0,
                      child: Text(
                        '00.00',
                        style: TextStyle(color: Colors.black87, fontSize: 25.0),
                      ),
                    ),
                  ),
                ),
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
                      list[index].aumentarSeries();
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
                    'Tiempo de Descanso',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w300),
                  ),
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
                          list[index].icon = Icon(
                            Icons.fitness_center,
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
            trailing: GestureDetector(
              onTap: () {
                setState(() {
                  list[index].weight = list[index].weight + 1;
                });
              },
              onLongPress: () {
                setState(() {
                  list[index].weight = 0;
                });
              },
              child: Container(
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
        backgroundColor: Theme.of(context).primaryColor,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
