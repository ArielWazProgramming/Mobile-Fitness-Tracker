import 'bmiCalculator.dart';
import 'dietTracking.dart';
import 'physicalTracking.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'main.dart';
import 'package:image_picker/image_picker.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  TextEditingController food = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController width = TextEditingController();

  File? _image;
  final picker = ImagePicker();

  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  // Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text('Photo Gallery'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AWK's Fitness | Settings"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: food,
              decoration: InputDecoration(hintText: 'Please input new user'),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(hintText: 'Please input new password'),
            ),
            TextField(
              controller: height,
              decoration: InputDecoration(hintText: 'Please input new height'),
            ),
            TextField(
              controller: width,
              decoration: InputDecoration(hintText: 'Please input new width'),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Settings updated.')));
              },
              child: Text("Save settings"),
            ),
            UserAccountsDrawerHeader(
              accountName: Text("Ariel"),
              accountEmail: Text("ariel@gmail.com"),
              currentAccountPicture: CircleAvatar(),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: showOptions,
              child: Text("Change profile image"),
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
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
