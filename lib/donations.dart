import 'package:flutter/material.dart';

class Donations extends StatefulWidget {
  const Donations({super.key});
  @override
  State<Donations> createState() => _DonationsState();
}

class _DonationsState extends State<Donations> {
  var currentIndex = 0;
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
      body: const Center(
        child: Text('Donations'),
      ),
    );
  }
}
