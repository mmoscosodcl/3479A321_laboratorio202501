import 'dart:async';

import 'package:application_laboratorio202501/pages/about.dart';
import 'package:application_laboratorio202501/pages/activity_page.dart';
import 'package:application_laboratorio202501/pages/list_labs.dart';
import 'package:application_laboratorio202501/pages/preference.dart';
import 'package:application_laboratorio202501/provider/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  
}
class _MyHomePageState extends State<MyHomePage> {
  bool _isResetEnabled = false;
  String _imageUrl = 'https://picsum.photos/250?image=10';
  String _filter = '';
  var logger = Logger();

  _MyHomePageState() {
    logger.d("constructor");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var logger = Logger();
    logger.d("initState");
    _loadPreferences();
    _getNewImage();
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

  Future<void> _loadPreferences() async {
  final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isResetEnabled = prefs.getBool('isResetEnabled') ?? false;
      _filter = _isResetEnabled ? '?grayscale' : '';
      
    });
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
 
 Future<void> _getNewImage() async {
    final newImageUrl = 'https://picsum.photos/250?image=${context.read<AppData>().counter}';
    try {
      final response = await http.head(Uri.parse(newImageUrl));
      logger.d("Response status: ${response.headers.toString()}");
      logger.d("Response status code: ${response.statusCode}");
      logger.d("New image URL: $newImageUrl");
      if (response.statusCode == 200  || response.statusCode == 404) {
        setState(() {
          _imageUrl = newImageUrl;
          logger.d("Get new image: $_imageUrl");
        });
      } else {
        setState(() {
          _imageUrl = ''; // Clear the image URL
          logger.e("Image not found: $newImageUrl");
        });
      }
    } catch (e) {
      setState(() {
        _imageUrl = ''; // Clear the image URL
        logger.e("Failed to fetch image: $e");
      });
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
      actions: [
        IconButton(
        icon: const Icon(Icons.account_circle),
        tooltip: 'User Profile',
        onPressed: () {
          Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const About()),
          );
        },
        ),
        PopupMenuButton<String>(
        onSelected: (value) {
          switch (value) {
          case 'list':
            Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ListLabs()),
            );
            break;
          case 'activity':
            Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ActivityPage()),
            );
            break;
          case 'about':
            Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const About()),
            );
            break;
          case 'settings':
            Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => PreferencePage()),
            ).then((_) {
              _loadPreferences();
            });
;
            break;
          }
        },
        itemBuilder: (context) => [
          const PopupMenuItem(
            value: 'list',
            child: ListTile(
              leading: Icon(Icons.list),
              title: Text('List'),
            ),
          ),
          const PopupMenuItem(
            value: 'activity',
            child: ListTile(
              leading: Icon(Icons.note_add),
              title: Text('Activity'),
            ),
          ),
          const PopupMenuItem(
          value: 'about',
          child: ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
          ),
          ),
          const PopupMenuItem(
          value: 'settings',
          child: ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          ),
        ],
        ),
      ],
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
              Image.network(
                _imageUrl.isNotEmpty ? _imageUrl : '',
                width: 250,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Text(
                  'Failed to load image $_imageUrl',
                  style: TextStyle(color: Colors.red),
                  ),
                );
              },
            ),
              const SizedBox(height: 20),
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
      TextButton(
        onPressed: _isResetEnabled ? context.read<AppData>().resetCounter : null,
        child: Icon(Icons.clean_hands),
      ),
      TextButton(
        onPressed: _getNewImage, // New button to refresh the image
        child: Icon(Icons.refresh),
      ),
    ];
  }
}
