import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomeState createState() => _HomeState();
}

List<Map<dynamic, dynamic>> lists = [];
List keys = [];

class _HomeState extends State<Home> {
  final dbRef = FirebaseDatabase.instance.reference().child("sembtrainee");
  //List<Map<dynamic, dynamic>> lists = [];
  List<String> names = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
            future: dbRef.once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData) {
                lists.clear();
                names.clear();
                keys.clear();
                Map<dynamic, dynamic> values = snapshot.data.value;
                values.forEach((key, values) {
                  lists.add(values);
                  keys.add(key);
                });
                return new ListView.builder(
                    shrinkWrap: true,
                    itemCount: lists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Nome: " + lists[index]["Nome"]),
                            Text("Status: " + lists[index]["Status"]),
                            Text("Leitura: " + lists[index]["Leitura"]),
                            Text("Tipo: " + lists[index]["Tipo"]),

                            // ______________________________
                            Center(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                  RaisedButton(
                                    child: Text('Ligar/Desligar'),
                                    onPressed: () {
                                      //print_number();
                                      if (lists[index]["Status"] == 'on') {
                                        print(lists);
                                        dbRef.child(keys[index])
                                            //.child("Status")
                                            .update({'Status': 'off'});
                                      }
                                      if (lists[index]["Status"] == 'off') {
                                        print(lists);
                                        dbRef.child(keys[index])
                                            //.child("Status")
                                            .update({'Status': 'on'});
                                      }
                                    },
                                  ),
                                ])),
                            //________________________________
                          ],
                        ),
                      );
                    });
              }
              return CircularProgressIndicator();
            }));
  }
}
