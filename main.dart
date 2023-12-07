import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'bmiCalculator.dart';
import 'physicalTracking.dart';
import 'settingPages.dart';
import 'dietTracking.dart';


void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  final appTitle = 'Mobile Fitness Tracker';
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String title = "";

  final String quoteURL = "https://api.adviceslip.com/advice";
  String quote = 'Random Quote';

  Future<void> generateQuote() async {
    try {
      final response = await http.get(Uri.parse(quoteURL));
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        setState(() {
          quote = result["slip"]["advice"];
        });
      } else {
        setState(() {
          quote = 'Failed to fetch quote';
        });
      }
    } catch (e) {
      setState(() {
        quote = 'Failed to fetch quote';
      });
    }
  }

  void setQuote()
  {
    setState(() {
      quote = 't';
    });
  }

  @override
  void initState() {
    super.initState();
    generateQuote();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Text(
          quote,
          style: TextStyle(fontSize: 20.0),
        ),
        widthFactor: 0.8,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Kebin"),
              accountEmail: Text("kkhi3@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.cyanAccent,
                child: Text(
                  "KK",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: (){
                generateQuote();
                Navigator.pop(context);
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