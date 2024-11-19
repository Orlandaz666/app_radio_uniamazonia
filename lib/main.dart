import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

void main() {
  runApp(RadioApp());
}

class RadioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RadioPlayer(),
    );
  }
}

class RadioPlayer extends StatefulWidget {
  @override
  _RadioPlayerState createState() => _RadioPlayerState();
}

class _RadioPlayerState extends State<RadioPlayer> {
  late VlcPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    setState(() {});
  }

  void _initializePlayer() { 

      _controller = VlcPlayerController.network(
        'http://radio.udla.edu.co:8000',
        hwAcc: HwAcc.full,
        autoPlay: false,
        options: VlcPlayerOptions(),
      );

    _controller.addListener(() {
      final state = _controller.value;
      if (state.hasError) {
        _showErrorDialog();
      }
      setState(() {});
    });

  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error de conexión'),
          content: const Text(
              'Sin conexion.Vuelva mas Tarde.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop(); 
                SystemNavigator.pop(); // C
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emisora Uniamazonia')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width *0.7, 
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/emisora_logo.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: VlcPlayer(
                controller: _controller,
                aspectRatio: 16 / 9,
                virtualDisplay: true,
              ),
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause_circle_filled :   Icons.play_circle_filled,
                size: 64,
                color: const Color(0xFF0B750E),
              ),
              onPressed: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();   
                }
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
