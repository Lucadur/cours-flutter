import 'package:flutter/material.dart';
void main() {
 runApp(const MyApp());
}
class MyApp extends StatelessWidget {
 const MyApp({super.key});
 @override
 Widget build(BuildContext context) {
 return MaterialApp(
 title: 'Flutter Demo',
 theme: ThemeData(
 colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  useMaterial3: true,
 ),
 home: const MyHomePage(title: 'Flutter Demo Home Page'),
 );
 }
}


class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}


class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter', style: TextStyle(color: Colors.white)),
        leading: const Icon(Icons.access_alarm, color: Color(0xFFFF00FF)),
        actions: <Widget>[
          IconButton(
              onPressed: btDown,
              icon: const Icon(
                Icons.supervised_user_circle,
                color: Colors.white,
              )),
        ],
        elevation: 10.0,
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  onPressed: btDown,
                  child: const Text("TextButton"),
                ),
                TextButton.icon(
                  onPressed: btDown,
                  label: const Text("TextButton"),
                  icon: const Icon(Icons.plus_one),
                ),
                ElevatedButton(
                    onPressed: () {}, child: const Text('ElevatedButton')),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(width: 200, height: 200),
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    label: const Text('Plus One'),
                    icon: const Icon(Icons.plus_one),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      textStyle: const TextStyle(fontSize: 20),
                      shape: const CircleBorder(),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: btDown,
                  child: const Text("OutlinedButton"),
                ),
                OutlinedButton.icon(
                  icon: const Icon(Icons.plus_one),
                  onPressed: btDown,
                  label: const Text("OutlinedButton"),
                ),
              ]),
        ),
      ),
    );
  }

  void btDown() {
    setState(() {
      print('Bouton appuyé');
    });
  }
}
