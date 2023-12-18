import 'bmiCalculator.dart';
import 'settingPages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dietTracking.dart';
import 'main.dart';

const List<String> list = <String>['Running', 'Cycling', 'Swimming'];

class PhysActPage extends StatefulWidget {
  const PhysActPage({super.key});

  @override
  State<PhysActPage> createState() => _PhysActPageState();
}

class _PhysActPageState extends State<PhysActPage> {

  TextEditingController activity = TextEditingController();
  TextEditingController time = TextEditingController();

  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AWK's Fitness | Physical Activity"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Text('Input the activity'),
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20,),
            TextField(
              controller: time,
              decoration: InputDecoration(hintText: 'Time spent on activity in minutes'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            ElevatedButton(
              onPressed: () {

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Log recorded.')));
              },
              child: Text("Log activity."),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              accountName: const Text("AWK's Fitness Tracker"),
              accountEmail: const Text("Track all your fitness needs!"),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage("assets/awklogo.png"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.accessibility),
              title: Text("Physical Activity"),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.fastfood_outlined),
              title: Text("Diet Tracking"),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const DietPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate_outlined),
              title: Text("BMI Calculator"),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BMIPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SettingPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

