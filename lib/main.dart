import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:another_flushbar/flushbar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class FoodItem {
  String name;
  int quantity;
  FoodItem(this.name, this.quantity);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Knightro Rice',
      theme: ThemeData(
        primarySwatch: Colors.green,
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
  var quantityTotal = 0;
  var kcTotal = 0;
  List<FoodItem> donationList = [];
  Flushbar errorBar = Flushbar(
    backgroundColor: Colors.red,
    message: "Invalid Input!",
    duration: const Duration(seconds: 2),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (AppBar(title: const Text('Knightro Rice'))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: donationList.length,
              itemBuilder: (BuildContext context, int i) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      'Item: ${donationList[i].name}',
                      style: const TextStyle(fontSize: 26),
                    ),
                    subtitle: Text(
                      'Quantity: ${donationList[i].quantity.toString()}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 75,
              child: ElevatedButton(
                onPressed: () => addDonationDialog(context),
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 42),
                ),
                child: const Text("Add Donation"),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Text('Knight Cash Earned: \$$kcTotal',
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  void addDonationDialog(BuildContext context) {
    var quantityController = TextEditingController();
    var itemController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Donation Item"),
          content: SizedBox(
            width: 250,
            height: 125,
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                    labelText: "Item Name",
                  ),
                  controller: itemController,
                ),
                TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Quantity",
                    ),
                    controller: quantityController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () => {
                if (itemController.text.isNotEmpty &&
                    quantityController.text.isNotEmpty &&
                    RegExp(r'^-?[0-9]+$').hasMatch(quantityController.text))
                  {
                    setState(() {
                      quantityTotal += int.parse(quantityController.text);
                      if (quantityTotal ~/ 5 > 0) {
                        kcTotal += quantityTotal ~/ 5;
                        quantityTotal = quantityTotal % 5;
                      }
                    }),
                    donationList.add(FoodItem(itemController.text,
                        int.parse(quantityController.text))),
                    Navigator.pop(context)
                  }
                else
                  {errorBar.show(context)}
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}
