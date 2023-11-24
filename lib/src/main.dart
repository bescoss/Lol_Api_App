import 'package:flutter/material.dart';
import 'dart:async';
import 'champion_model.dart';
import 'champion_list.dart';
import 'new_champion_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My favourite Champions',
      theme: ThemeData(brightness: Brightness.dark),
      home: const MyHomePage(
        title: 'My favourite Champions',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Champion> initialChampion = [
    Champion('Fiora'),
    Champion('Ornn'),
    Champion('Teemo'),
    Champion('Shen'),
  ];

  Future<void> _showNewChampionForm() async {
    // Navigate to the AddChampionFormPage and await the result
    var result = await Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return const AddChampionFormPage();
      },
    ));

    // Check if the result is not null and is of type Champion
    if (result != null && result is Champion) {
      // Add the new champion to the list and update the state
      initialChampion.add(result);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(10, 20, 40, 100),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: TextButton(
                onPressed: _showNewChampionForm,
                child: const Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    SizedBox(
                        width: 8), // Add some space between the icon and text
                    Text(
                      'Add new champion',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
      body: Container(
          color: const Color.fromRGBO(10, 50, 60, 100),
          child: Center(
            child: ChampionList(initialChampion),
          )),
    );
  }
}
