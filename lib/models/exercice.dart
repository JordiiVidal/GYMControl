import 'package:flutter/material.dart';

class Exercice{

  final String name;
  int repetitions;
  int series;
  int actualSeries;
  double weight;
  bool start;
  bool recoveryTime;

  Exercice({ @required this.name, @required this.weight, @required this.repetitions, @required this.series,@required this.actualSeries,@required this.start, @required this.recoveryTime});

  void increaseSeries(){
    if(this.actualSeries < this.series){
      this.actualSeries++;
    }else{
      print('fin');
    }
  }

  void increaseWeight(){
    this.weight += 0.5;
  }

  void decreaseWeight(){
    if(this.weight > 0){
      this.weight -= 0.5;
    }
  }
}