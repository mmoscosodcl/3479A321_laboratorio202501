import 'package:application_laboratorio202501/pages/about.dart';
import 'package:application_laboratorio202501/pages/list_labs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _goToList() {
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListLabs(),
      ),
    ); 

  }
  void _goToAbout() {
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const About(),
      ),
    );
  }

  void _goNext() {
    if (_counter % 2 == 0) {
      _goToList();
    } else {
      _goToAbout();
    }
  }
 


  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      persistentFooterButtons: footerOptions,
  
      body: Center(
        child: Card(
          elevation: 10,
          margin: EdgeInsets.all(20),
          color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset('assets/icons/mobile.svg',semanticsLabel: 'Dart Logo',),
              const Text('Usted a pulsado el boton las siguientes veces:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: _goNext, child: Text("Win")),
                  const SizedBox(width: 20),
                  TextButton(onPressed: _goNext, child: Text("Lose")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }




  List<Widget> get footerOptions {
    return [
      TextButton(onPressed: _incrementCounter, child: Icon(Icons.add)),
      TextButton(onPressed: _decrementCounter, child: Icon(Icons.remove)),
      TextButton(onPressed: _resetCounter, child: Icon(Icons.clean_hands)),
    ];
  }
}
