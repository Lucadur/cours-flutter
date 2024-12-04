import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});
  @override
  Widget build(BuildContext context) {
    String name = "Lucas";
    DateTime date = DateTime.now();
    String formattedDate = " ${date.day}/${date.month}/${date.year} ";
    return Scaffold(
        appBar: AppBar(
          title: const Text('À propos', style: TextStyle(color: Colors.blue)),
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
              child: Card(
                  elevation: 15.0,
                  color: Colors.blueGrey,
                  child: SizedBox(
                    width: 300.0,
                    height: 300.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Application Flutter développée par $name",
                            style: const TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        Text("Créée le $formattedDate",
                            style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        const Text("Licence : MIT"),
                        const Text("Tools • Dart 3.5.4 • DevTools 2.37.3"),
                      ],
                    ),
                  ))),
          Expanded(
            child: Card(
              elevation: 15.0,
              color: Colors.lightBlue,
              child: SizedBox(
                  width: 300.0,
                  height: 300.0,
                  child: Image.network(
                      'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif')),
            ),
          ),
        ]));
  }
}
