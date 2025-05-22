import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencePage extends StatefulWidget {
  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  bool _isResetEnabled = false;



  Future<void> _loadPreferences() async {
  final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isResetEnabled = prefs.getBool('isResetEnabled') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    Logger logger = Logger();
    logger.d("Saving preferences");
    final prefs = await SharedPreferences.getInstance();
    logger.d("Saving _isResetEnabled: $_isResetEnabled");
    await prefs.setBool('isResetEnabled', _isResetEnabled);
  }


  @override
  void initState() {
    super.initState();
    // Initialize the state with default values
    _loadPreferences();
  }

  @override
  void dispose() {
    // Save preferences when the widget is disposed
    _savePreferences();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SwitchListTile(
              title: Text('Reset counter enabled'),
              value: _isResetEnabled,
              onChanged: (value) {
              setState(() {
                _isResetEnabled = value;
                _savePreferences();
              });
              },
            ),
          ],
        ),
      ),
    );
  }
}