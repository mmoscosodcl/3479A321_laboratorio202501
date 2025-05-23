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
          return Dismissible(
            key: Key(activity.id.toString()), // Unique key for each item
            direction: DismissDirection.endToStart, // Allow sliding to the left
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            confirmDismiss: (direction) async {
              // Show a dialog to confirm the action
              if (direction == DismissDirection.endToStart) {
                return await _showDeleteConfirmationDialog(activity);
              }
              return false;
            },
            child: ListTile(
              title: Text(activity.name),
              subtitle: Text(activity.date.toIso8601String()),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showUpdateDialog(activity);
                },
              ),
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
  
  Future<bool> _showDeleteConfirmationDialog(Activity activity) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Confirm Delete'),
              content: Text('Are you sure you want to delete "${activity.name}"?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false), // Cancel
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await _dbHelper.deleteActivity(activity.id);
                    _loadActivities();
                    Navigator.of(context).pop(true); // Confirm
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        ) ??
        false; // Return false if the dialog is dismissed
  }
  
  void _showUpdateDialog(Activity activity) {
    final TextEditingController _nameController =
        TextEditingController(text: activity.name);
  
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Activity'),
          content: TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Activity Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                final updatedActivity = Activity(
                  id: activity.id,
                  date: activity.date,
                  name: _nameController.text,
                );
                await _dbHelper.updateActivity(updatedActivity);
                _loadActivities();
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}