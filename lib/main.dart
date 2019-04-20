import 'package:flutter/material.dart';
import 'models/exercice.dart';
import 'pages/exercice_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }

}
class _MyAppState extends State<MyApp>{

  List<Exercice> list = [
    Exercice(
      name: 'Press de banca',
      weight: 45.5,
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymControl',
      theme: ThemeData(
          primaryColor: Colors.teal[800], accentColor: Colors.teal[700]),
      home: ExerciceListPage(list),
    );
  }
}
