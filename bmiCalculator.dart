import 'settingPages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dietTracking.dart';
import 'physicalTracking.dart';
import 'main.dart';

class BMIPage extends StatefulWidget {
  const BMIPage({super.key});

  @override
  State<BMIPage> createState() => _BMIPageState();
}

class _BMIPageState extends State<BMIPage> {

  TextEditingController weightTC = TextEditingController();
  TextEditingController heightTC = TextEditingController();

  double _bmiScore = 00.00;

  double calculateBMI(double weight, double height)
  {
    double result = 0.0;

    double lower = height*height;

    result = weight/lower;

    return result;
  }
  void updateBMI(double newBMI)
  {
    _bmiScore = newBMI;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('BMI Calculator'),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.calculate_outlined),
                  text: "Calculate",
                ),
                Tab(
                  icon: Icon(Icons.table_chart),
                  text: "Chart",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    TextField(
                      controller: weightTC,
                      decoration: InputDecoration(hintText: 'Input your weight in kg'),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]')),],
                    ),
                    TextField(
                      controller: heightTC,
                      decoration: InputDecoration(hintText: 'Input your height in meters'),
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]')),],
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                        double newBMI = calculateBMI(double.parse(weightTC.text), double.parse(heightTC.text));
                        updateBMI(newBMI);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Log recorded.')));
                      },
                      child: Text("Calculate BMI"),
                    ),
                    SizedBox(height: 30,),
                    Text("BMI Score is: " + _bmiScore.toStringAsFixed(2)),
                  ],
                ),

              ),
              Center(
                child: Image.asset("assets/bmi-chart.png"),
              ),
            ],
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const DietPage()));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.calculate_outlined),
                  title: Text("BMI Calculator"),
                  onTap: (){
                    Navigator.pop(context);
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
        )
    );
  }
}

/*

Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: weightTC,
              decoration: InputDecoration(hintText: 'Input your weight in kg'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]')),],
            ),
            TextField(
              controller: heightTC,
              decoration: InputDecoration(hintText: 'Input your height in meters'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[0-9.]')),],
            ),
            ElevatedButton(
              onPressed: () {
                double newBMI = calculateBMI(double.parse(weightTC.text), double.parse(heightTC.text));
                updateBMI(newBMI);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Log recorded.')));
              },
              child: Text("Calculate BMI"),
            ),
            SizedBox(height: 30,),
            Text("BMI Score is: " + _bmiScore.toStringAsFixed(2)),
          ],
        ),

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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage(title: "Welcome Back!")));
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
              leading: Icon(Icons.water_drop_outlined),
              title: Text("Water Tracking"),
              onTap: (){
                Navigator.pop(context, );
              },
            ),
            ListTile(
              leading: Icon(Icons.calculate_outlined),
              title: Text("BMI Calculator"),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.balance),
              title: Text("Weight Tracking"),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );

 */