import 'package:app_radio_uniamazonia/ui/Radio_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const RadioApp());
}

class RadioApp extends StatelessWidget {
  const RadioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      home: const RadioPlayer(),
    );
    
  }
}
