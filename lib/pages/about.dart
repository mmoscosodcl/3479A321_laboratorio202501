import 'package:application_laboratorio202501/provider/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('About Page'),
            SizedBox(height: 20),
            Text('${context.read<AppData>().counter}'),
            SizedBox(height: 20),
            
            TextFormField(
              initialValue: context.read<AppData>().name,
              decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter your username',
              ),
              onChanged: (value) {
                context.read<AppData>().setName(value);
              },
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Enable Reset'),
              value: context.watch<AppData>().isResetEnabled,
              onChanged: (bool value) {
                context.read<AppData>().setResetEnabled(value);
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Volver"),
            )
          ],
        ),
      ),
    );
  }
}