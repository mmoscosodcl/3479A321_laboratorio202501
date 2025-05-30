import 'package:application_laboratorio202501/pages/my_home_page.dart';
import 'package:application_laboratorio202501/provider/counter_provider.dart';
import 'package:application_laboratorio202501/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:application_laboratorio202501/style/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database
  await DatabaseHelper().initializeDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final MaterialTheme materialTheme = MaterialTheme(
      ThemeData.light().textTheme, // Use the default light text theme
    );
    var logger = Logger();

    logger.d("Logger is working!");

    return ChangeNotifierProvider<AppData>(
      create: (context) => AppData(),
      child: MaterialApp(
      title: 'Laboratorio 2025/01',
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      home: const MyHomePage(title: 'Laboratorio 2025/01'),
      )
    );
  }
}

