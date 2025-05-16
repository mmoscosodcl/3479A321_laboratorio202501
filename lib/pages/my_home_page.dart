import 'package:application_laboratorio202501/pages/about.dart';
import 'package:application_laboratorio202501/pages/list_labs.dart';
import 'package:application_laboratorio202501/provider/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() {
    var logger = Logger();
    logger.d("create state");
    return _MyHomePageState();
  }
}
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  _MyHomePageState() {
    var logger = Logger();
    logger.d("constructor");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var logger = Logger();
    logger.d("initState");
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    var logger = Logger();
    logger.d("didUpdateWidget");
  }
  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    var logger = Logger();
    logger.d("didChangeDependencies");
  }
  @override
  void dispose() {
    super.dispose();
    var logger = Logger();
    logger.d("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    var logger = Logger();
    logger.d("reassemble");
  }

  @override
  deactivate() {
    super.deactivate();
    var logger = Logger();
    logger.d("deactivate");
  }





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
    if (context.read<AppData>().counter % 2 == 0) {
      _goToList();
    } else {
      _goToAbout();
    }
  }
 


  @override
  Widget build(BuildContext context) {
    var logger = Logger();
    logger.d("build");

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
                Text(
                context.watch<AppData>().name,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Text('Usted a pulsado el boton las siguientes veces:'),
              Text(
                '${context.watch<AppData>().counter}',
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
      TextButton(onPressed: context.read<AppData>().increment, child: Icon(Icons.add)),
      TextButton(onPressed: context.read<AppData>().decrement, child: Icon(Icons.remove)),
      Selector<AppData, bool>(
        selector: (_, appData) => appData.isResetEnabled,
        builder: (context, isResetEnabled, child) {
          return TextButton(
        onPressed: isResetEnabled ? context.read<AppData>().resetCounter : null,
        child: Icon(Icons.clean_hands),
          );
        },
      ),
    ];
  }
}
