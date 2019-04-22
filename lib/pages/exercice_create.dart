import 'package:flutter/material.dart';

class ExerciceCreate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExerciceCreateState();
  }
}

class _ExerciceCreateState extends State<ExerciceCreate> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        centerTitle: true,
        title: Text('Crear Ejercicio'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              style: TextStyle(color: Colors.black87, fontSize: 18.0),
              cursorColor: Colors.red,
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
              onChanged: (String inputText) {
                setState(() {
                  name = inputText;
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 150.0,
                child: TextField(
                  decoration: InputDecoration(
                    helperText: 'Series',
                    icon: Image(
                      image: AssetImage("assets/gym_02.png"),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Container(
                width: 150.0,
                child: TextField(
                  decoration: InputDecoration(
                    helperText: 'Repeticiones',
                    icon: Image(
                      image: AssetImage("assets/gym_02.png"),
                    ),
                  ),
                  keyboardType: TextInputType.number,
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
              onPressed: (){},
          ),
        ],
      ),
    );
  }
}
