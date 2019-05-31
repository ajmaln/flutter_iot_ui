import 'package:flutter/material.dart';
import 'package:iot_ui/screens/deviceScreen/co2Sensor.dart';
import 'package:iot_ui/screens/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IOT App',
      theme: ThemeData(
        primaryColor: Color(0xff001848),
        accentColor: Colors.lightBlue[300],
        //primarySwatch: Colors.grey,
        splashColor: Colors.lightBlueAccent,
        primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25.0))
      ),
      home: Home(),
      routes: <String, WidgetBuilder> {
        'co2Sensor/': (BuildContext context) => CO2Sensor(),
      },
    );
  }
}

