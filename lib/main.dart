import 'package:emergencyApp/landing.dart';
import 'package:emergencyApp/notifiers/emergencyNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => EmergencyNotifier(),
      ),
     
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AnimationController c;
    
    return MaterialApp(
      title: 'Flutter Emergency App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:Landing(),
    );
  }
}

