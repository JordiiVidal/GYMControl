import 'package:flutter/material.dart';

class ExerciceDB{

  int id;
  String name;
  String repetitions;
  String series;
  String actualSeries;
  String weight;
  String recoveryTime;
  bool start;
  
  ExerciceDB(this.id, this.name, this.repetitions, this.series, this.actualSeries, this.weight, this.recoveryTime, this.start);
}