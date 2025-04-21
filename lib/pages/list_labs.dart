import 'package:flutter/material.dart';

class ListLabs extends StatelessWidget {
  ListLabs({super.key});
  final List<String> labs = [
    'Laboratorio 1',
    'Laboratorio 2',
    'Laboratorio 3',
    'Laboratorio 4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Laboratorios'),
      ),
      body: ListView.builder(
        itemCount: labs.length,
        itemBuilder: (context, index) {
          return ListTile(
        title: Text(labs[index]),
        onTap: () {
          // Handle tap event if needed
        },
          );
        },
      ),
    );
  }
}