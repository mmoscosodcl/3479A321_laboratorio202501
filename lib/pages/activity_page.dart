import 'package:application_laboratorio202501/entity/activity.dart';
import 'package:application_laboratorio202501/services/database_helper.dart';
import 'package:flutter/material.dart';


class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Activity> _activities = [];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    final activities = await _dbHelper.getActivities();
    setState(() {
      _activities = activities;
    });
  }

  Future<void> _addActivity() async {
    final newActivity = Activity(
      id: DateTime.now().millisecondsSinceEpoch,
      date: DateTime.now(),
      name: 'New Activity',
    );
    await _dbHelper.insertActivity(newActivity);
    _loadActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activities'),
      ),
      body: ListView.builder(
        itemCount: _activities.length,
        itemBuilder: (context, index) {
          final activity = _activities[index];
          return ListTile(
            title: Text(activity.name),
            subtitle: Text(activity.date.toIso8601String()),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                await _dbHelper.deleteActivity(activity.id);
                _loadActivities();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addActivity,
        child: const Icon(Icons.add),
      ),
    );
  }
}