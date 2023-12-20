import 'package:flutter/material.dart';
import 'database_helper2.dart';

class EditSettingsPage extends StatefulWidget {
  final Map<String, dynamic> setting;

  EditSettingsPage({required this.setting});

  @override
  _EditSettingsPageState createState() => _EditSettingsPageState();
}

class _EditSettingsPageState extends State<EditSettingsPage> {
  TextEditingController foodController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    foodController.text = widget.setting['food'];
    passwordController.text = widget.setting['password'];
    heightController.text = widget.setting['height'];
    widthController.text = widget.setting['width'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AWK's Fitness Tracker | Edit "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: foodController,
              decoration: InputDecoration(labelText: 'User'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextField(
              controller: heightController,
              decoration: InputDecoration(labelText: 'Height'),
            ),
            TextField(
              controller: widthController,
              decoration: InputDecoration(labelText: 'Width'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _updateSettings(context);
              },
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateSettings(BuildContext context) async {
    Map<String, dynamic> updatedRow = {
      'food': foodController.text,
      'password': passwordController.text,
      'height': heightController.text,
      'width': widthController.text,
    };

    await DatabaseHelper2.instance.updateSetting(widget.setting['id']);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Settings updated successfully')),
    );

    Navigator.pop(context);
  }
}
