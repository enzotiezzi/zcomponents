import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MaterialFormsSample extends StatefulWidget {
  const MaterialFormsSample({Key? key}) : super(key: key);

  @override
  _MaterialFormsSampleState createState() => _MaterialFormsSampleState();
}

class _MaterialFormsSampleState extends State<MaterialFormsSample> {
  double _salary = 2500.0;

  bool _vtSelecionado = false;
  bool _vaSelecionado = false;

  TextEditingController _dataNascimentoTextController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Texto da Appbar"),
      ),
      body: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new ListView(
          children: [
            new Container(
              padding: const EdgeInsets.all(4.0),
              child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(),
                    labelText: "Nome Completo"),
              ),
            ),
            new Container(
              padding: const EdgeInsets.all(4.0),
              child: new TextField(
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(), labelText: "Nome da mãe"),
              ),
            ),
            new Container(
              padding: const EdgeInsets.all(4.0),
              child: new TextField(
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(), labelText: "Nome do pai"),
              ),
            ),
            new Container(
              padding: const EdgeInsets.all(8.0),
              child: new TextField(
                controller: _dataNascimentoTextController,
                keyboardType: TextInputType.datetime,
                textInputAction: TextInputAction.unspecified,

                onTap: () async {
                  var selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2030),
                    builder: (BuildContext context,  child) {
                      return Theme(
                        data: ThemeData.dark(),
                        child: child!,
                      );
                    },
                  );

                  setState(() {
                    _dataNascimentoTextController.text = new DateFormat("dd/MM/yyyy").format(selectedDate!);
                  });
                },
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(),
                    labelText: "Data de Nascimento"
                ),
              ),
            ),
            new Container(
              padding: const EdgeInsets.all(8.0),
              child: new Column(
                children: [
                  new Text("Faixa salarial: ${_salary.toStringAsFixed(0)}"),
                  new Slider(
                      value: _salary,
                      min: 1000.0,
                      max: 5000.0,
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (double newValue) {
                        setState(() {
                          _salary = newValue;
                        });
                      })
                ],
              ),
            ),
            new Container(
              padding: const EdgeInsets.all(8.0),
              child: new Column(
                children: [
                  new Text("Benefícios"),
                  new CheckboxListTile(
                      value: _vtSelecionado,
                      secondary: new Icon(Icons.emoji_transportation),
                      title: new Text("Vale transporte"),
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: (newValue) {
                        setState(() {
                          _vtSelecionado = newValue!;
                        });
                      }),
                  new CheckboxListTile(
                      value: _vaSelecionado,
                      secondary: new Icon(Icons.fastfood_sharp),
                      title: new Text("Vale alimentação"),
                      activeColor: Theme.of(context).primaryColor,
                      onChanged: ( newValue) {
                        setState(() {
                          _vaSelecionado = newValue!;
                        });
                      }),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
