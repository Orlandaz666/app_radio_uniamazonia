import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(RadioApp());
}

class RadioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
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
  double _volumeListenerValue = 0;

  void _initializeVolume() async {
    // Obtén el volumen actual del sistema
    double? currentVolume = await FlutterVolumeController.getVolume();
    setState(() {
      _volumeListenerValue = currentVolume!;
    });
  }

  void _initializePlayer() {
    _controller = VlcPlayerController.network(
      'http://181.235.184.156:8000/',
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

  _showFollowUsDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Síguenos en:',
            textAlign: TextAlign.center,
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [            
              _socialmedia(const FaIcon(FontAwesomeIcons.squareFacebook), 'https://www.facebook.com/uniamazonia.edu.co'),
              const SizedBox(width: 10),
              _socialmedia(const FaIcon(FontAwesomeIcons.squareInstagram), 'https://www.instagram.com/uniamazonia'),
              const SizedBox(width: 10),
              _socialmedia(const FaIcon(FontAwesomeIcons.xTwitter), 'https://x.com/uniamazonia'),
              const SizedBox(width: 10),
              _socialmedia(const FaIcon(FontAwesomeIcons.tiktok), 'https://www.tiktok.com/@uniamazonia'),
              const SizedBox(width: 10),
              _socialmedia(const FaIcon(FontAwesomeIcons.globe), 'https://www.uniamazonia.edu.co'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
                foregroundColor: const Color(0xFF0B750E),
              ),
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      //print('No se pudo abrir el enlace: $url');
    }
  }

  _showAboutUsDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Hecho por:',
            textAlign: TextAlign.center, // Centrar el título
          ),
          content: const Text(
            'Oficina de Gestión de Información y Comunicaciones\n'
            'V 1.0.0',
            textAlign: TextAlign.center, // Centrar el contenido del texto
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
                foregroundColor: const Color(0xFF0B750E),
              ),
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showErrorDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error de conexión'),
          content: const Text('Sin conexion. Vuelva mas Tarde.'),
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

//Widgets

  _socialmedia(FaIcon faicon, String url) {
  return GestureDetector(
    onTap: () => _launchURL(url),
    child: FaIcon(
      faicon.icon,  // Usar el icono del FaIcon pasado como parámetro
      size: 35,
      color: const Color(0xFF0B750E),
    ),
  );
}


  _listitle(Icon icon, Text text, method) {
    return ListTile(
      leading: Icon(
        icon.icon,
        color: const Color(0xFF0B750E),
        size: 30,
      ),
      title: text,
      onTap: () {
        method();
      },
    );
  }

//Override

  @override
  void initState() {
    super.initState();
    _initializePlayer();
    _initializeVolume();
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color(0xFF0B750E),
        ),
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/Logo_Emisora_Uniamazonia.jpg'),
                    fit: BoxFit.contain),
                color: Colors.white,
              ),
              child: Text(''),
            ),
            const SizedBox(height: 20),
            _listitle(const Icon(Icons.info_outline_rounded),
                const Text('Acerca de'), _showAboutUsDialog),
            _listitle(const Icon(Icons.language), const Text('Siguenos'),
                _showFollowUsDialog),
            // _listitle(const Icon(Icons.share), const Text('Comparte'),
            //     _showFollowUsDialog),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.7,
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.4,
              child: Row(
                children: [
                  const Icon(Icons.volume_down, color: Colors.grey),
                  Expanded(                  
                    child: Slider(   
                      min: 0,
                      max: 1,
                      activeColor:
                          const Color(0xFF0B750E), // Color de la barra activa
                      inactiveColor: Colors.green, // Color de la barra inactiva
                      onChanged: _controller.value.isPlaying
                          ? (double value) {
                              _volumeListenerValue = value;
                              FlutterVolumeController.setVolume(
                                  _volumeListenerValue);
                              setState(() {});
                            }
                          : null,
                      value: _volumeListenerValue,
                    ),
                    ),
                  const Icon(Icons.volume_up,
                      color: Colors.grey), // Ícono de volumen máximo
                ],
              ),
            ),
            SizedBox(
              child: IconButton(
                icon: Icon(
                  _controller.value.isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
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
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}