import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "demo",
      home: MyHome(),

    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  double iconSize = 40;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.android),
                  text: "This is Android",
                ),
                Tab(
                  icon: Icon(Icons.phone_iphone),
                  text: "This is Iphone",
                ),
              ],
            ),
            title: Text('Tab Bar and View Demo'),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Text('Android'),
              ),
              Center(
                child: Text('Iphone'),
              ),
            ],
          ),
        ));
  }
}