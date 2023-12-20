import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'EditSettingsPage.dart';
import 'database_helper2.dart';
import 'bmiCalculator.dart';
import 'physicalTracking.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

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
              Navigator.of(context).pop();
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: Text('Camera'),
            onPressed: () {
              Navigator.of(context).pop();
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
      body: ListView(
        children: [
          Container(
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
                  onPressed: _saveSettings,
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
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: _showDBEntries,
                  child: Text("Update shown DB Entries"),
                ),
                SizedBox(height: 20,),
                Text("All Database Entries", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: DatabaseHelper2.instance.getAllSettings(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      List<Map<String, dynamic>> settings = snapshot.data ?? [];
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: settings.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('User: ${settings[index]['food']}'),
                            subtitle: Text('Height: ${settings[index]['height']}, Width: ${settings[index]['width']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () => _editSetting(settings[index]),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () => _deleteSetting(settings[index]['id']),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
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

  Future<void> _saveSettings() async {
    Map<String, dynamic> row = {
      'food': food.text,
      'password': password.text,
      'height': height.text,
      'width': width.text,
    };

    int id = await DatabaseHelper2.instance.insertSetting(row);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Settings updated. ID: $id')),
    );
  }

  Future<void> _showDBEntries() async {
    setState(() {});
  }

  void _editSetting(Map<String, dynamic> setting) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSettingsPage(setting: setting),
      ),
    );
  }


  void _deleteSetting(int id) async {
    await DatabaseHelper2.instance.deleteSetting(id);
    _showDBEntries();
  }
}
