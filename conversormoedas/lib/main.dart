import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=6b041464";

void main() async{
  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
      hintColor: Colors.amber,
      primaryColor: Colors.white
    ),
  ));
}


Future<Map> getData() async{
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final realController = TextEditingController();
  final euroController = TextEditingController();
  final dollarController = TextEditingController();

  double dollar;
  double euro;

  void _realChange(String text){
    double real = double.parse(text);
    dollarController.text = (real/dollar).toStringAsFixed(2);
    euroController.text = (real/euro).toStringAsFixed(2);
  }
  void _dollarChange(String text){
    double dollar = double.parse(text);
    realController.text = (dollar * this.dollar).toStringAsFixed(2);
    euroController.text = (dollar * this.dollar / euro).toStringAsFixed(2);
  }
  void _euroChange(String text){
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dollarController.text = (euro * this.euro / dollar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Conversor \$' ),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: 
                  Text("Carregando Dados",
                    style: TextStyle(
                    color: Colors.amber, 
                    fontSize: 25.0 
                  ),
                  textAlign: TextAlign.center,)
                );
            case ConnectionState.active:
            case ConnectionState.done:
            //defaut:
              if (snapshot.hasError){
                Center(
                  child: 
                    Text("Erro ao carregar dados",
                    style: TextStyle(
                    color: Colors.amber, 
                    fontSize: 25.0 
                    ),
                    textAlign: TextAlign.center,)
                  );
                } else {
                  dollar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                  return SingleChildScrollView(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Icon(Icons.monetization_on, size: 150.0, color: Colors.amber),
                        buildTextField("Reias", "R\$", realController, _realChange),
                        Divider(),
                        buildTextField("Dollar", "US\$", dollarController, _dollarChange),
                        Divider(),
                        buildTextField("Euro", "€\$", euroController, _euroChange),
                      ],
                    ),
                  );
              }
          }
        }
        ),
    );
  }
}
Widget buildTextField(String lbl, String prefix, TextEditingController c, Function f){
  return TextField(
    controller: c,
    decoration: InputDecoration(
    labelText: lbl,
    labelStyle: TextStyle(color: Colors.amber),
    border: OutlineInputBorder(),
    prefixText: prefix
    ),
    style: TextStyle(
    color: Colors.amber, fontSize: 25.0
    ),
    keyboardType: TextInputType.number,
    onChanged: f,
  );
}