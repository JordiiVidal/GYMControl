import 'package:flutter/material.dart';
import 'package:gymcontrol/database/DBHelper.dart';
import 'package:gymcontrol/models/exercice_db.dart';

class ExerciceCreate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExerciceCreateState();
  }
}

class _ExerciceCreateState extends State<ExerciceCreate> {
  
  ExerciceDB exerciceDB = ExerciceDB();

  String name, repetitions, series, actualSeries, weight;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        leading: BackButton(),
        centerTitle: true,
        title: Text('Crear Ejercicio'),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                style: TextStyle(color: Colors.black87, fontSize: 18.0),
                decoration: InputDecoration(
                  helperText: 'Nombre',
                  filled: true,
                  fillColor: Colors.teal[100],
                  counterStyle: TextStyle(color: Colors.white),
                  icon: Image(
                    image: new AssetImage("assets/exercice.png"),
                  ),
                ),
                maxLength: 25,
                validator: (val) =>
                    val.length == 0 ? 'Escribir nombre ejercicio' : null,
                onSaved: (val) => this.name = val,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 150.0,
                  child: TextFormField(
                    decoration: InputDecoration(
                      helperText: 'Series',
                      icon: Image(
                        image: AssetImage("assets/gym_02.png"),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) => val.length == 0 ? 'Series' : null,
                    onSaved: (val) => this.series = val,
                  ),
                ),
                Container(
                  width: 150.0,
                  child: TextFormField(
                    decoration: InputDecoration(
                      helperText: 'Repeticiones',
                      icon: Image(
                        image: AssetImage("assets/gym_02.png"),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (val) => val.length == 0 ? 'Rep' : null,
                    onSaved: (val) => this.repetitions = val,
                  ),
                ),
              ],
            ),
            Center(
              child: Text('sasa'),
            ),
            FloatingActionButton.extended(
              icon: Icon(Icons.save),
              label: Text('Guardar'),
              onPressed: submitExercice,
            ),
          ],
        ),
      ),
    );
  }

  void submitExercice() {

    print('submit');

    if (this.formKey.currentState.validate()) {
      formKey.currentState.save();
    } else {
      return null;
    }

    var exercice = ExerciceDB();
    exercice.name = name;
    exercice.repetitions = repetitions;
    exercice.series = series;
    exercice.actualSeries = '0';
    exercice.weight = '0';

    var dbHelper = DBHelper();
    dbHelper.addNewExercice(exercice);
    
  }
}
