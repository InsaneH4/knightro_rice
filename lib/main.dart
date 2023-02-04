import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knightro Rice',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Knightro Rice'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedIndex: currentIndex,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.list), label: 'Donations'),
          NavigationDestination(icon: Icon(Icons.star), label: 'Rewards'),
        ],
      ),
      appBar: (AppBar(title: const Text('Donations'))),
      body: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Text('Donations'),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: 75,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 42),
                  ),
                  child: const Text("Add Donation"),
                ),
              ),
            ],
          ),
        ),
        const Text('Rewards'),
      ][currentIndex],
    );
  }
}
