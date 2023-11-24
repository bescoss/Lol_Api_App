import 'champion_model.dart';
import 'package:flutter/material.dart';

class AddChampionFormPage extends StatefulWidget {
  const AddChampionFormPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddChampionFormPageState createState() => _AddChampionFormPageState();
}

class _AddChampionFormPageState extends State<AddChampionFormPage> {
  TextEditingController nameController = TextEditingController();

  void submitPup(BuildContext context) {
    if (nameController.text.isEmpty) {
      Navigator.of(context).pop(null); // Return null if the name is empty
    } else {
      var newChampion = Champion(nameController.text);
      Navigator.of(context).pop(newChampion);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new champion'),
        backgroundColor: const Color.fromRGBO(10, 20, 40, 100),
      ),
      body: Container(
        color: const Color.fromRGBO(10, 50, 60, 100),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: nameController,
                style: const TextStyle(decoration: TextDecoration.none),
                onChanged: (v) => nameController.text = v,
                decoration: const InputDecoration(
                  labelText: 'Champion Name',
                  labelStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {
                  return ElevatedButton(
                      onPressed: () => submitPup(context),
                      child: const Text(
                        'Submit Champion',
                        style: TextStyle(
                            color: Color.fromRGBO(240, 230, 210, 100)),
                      ));
                },
              ),
            ),
            Expanded(
              child: Image.asset(
                'assets/images/lolimage.jpg', // replace with your image path
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
