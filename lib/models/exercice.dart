import 'package:flutter/material.dart';


class Exercice{

  final String name;
  int repetitions;
  int series;
  int actualSeries;
  int weight;
  bool start;
  bool recoveryTime;
  Icon icon;

  Exercice({ @required this.name, @required this.weight, @required this.repetitions, @required this.series,@required this.actualSeries,@required this.start, @required this.recoveryTime, @required this.icon});

  void aumentarSeries(){
    if(this.actualSeries < this.series){
      this.actualSeries++;
    }else{
      print('fin');
    }
  }
}