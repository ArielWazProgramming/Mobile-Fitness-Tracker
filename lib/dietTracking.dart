import 'bmiCalculator.dart';
import 'physicalTracking.dart';
import 'settingPages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class DietPage extends StatefulWidget {
  const DietPage({super.key});

  @override
  State<DietPage> createState() => _DietPageState();
}

class _DietPageState extends State<DietPage> {

  TextEditingController food = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController calories = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AWK's Fitness | Diet Tracking"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: food,
              decoration: InputDecoration(hintText: 'Please input the food consumed'),
            ),
            TextField(
              controller: amount,
              decoration: InputDecoration(hintText: 'Please input the amount of portion '),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            TextField(
              controller: calories,
              decoration: InputDecoration(hintText: 'Please input the amount of calories per portion'),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Log recorded.')));
              },
              child: Text("Log food, portions and calories."),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PhysActPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.fastfood_outlined),
              title: Text("Diet Tracking"),
              onTap: (){
                Navigator.pop(context, );
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

















/*mydb.db.rawInsert(
                    "insert into students (name, roll_no, address) values (?, ?, ?);",
                    [
                      name.text,
                      rollno.text,
                      address.text
                    ]);*/