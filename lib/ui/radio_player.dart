import 'package:app_radio_uniamazonia/constants/constants.dart';
import 'package:app_radio_uniamazonia/services/conectivity_service.dart';
import 'package:app_radio_uniamazonia/services/vlc_service.dart';
import 'package:app_radio_uniamazonia/ui/widgets/list_drawer.dart';
import 'package:app_radio_uniamazonia/ui/widgets/show_dialog.dart';
import 'package:app_radio_uniamazonia/ui/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';

class RadioPlayer extends StatefulWidget {
  const RadioPlayer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  RadioPlayerState createState() => RadioPlayerState();
}

class RadioPlayerState extends State<RadioPlayer> {
  late VlcService _vlcService;
  late ConectivityService _conectivityService;
  
  double _volumeListenerValue = 0;
  bool playing = false;
 

  void _initializeVolume() async {
    double? currentVolume = await FlutterVolumeController.getVolume();
    setState(() {
      _volumeListenerValue = currentVolume!;
    });
  }

  @override
  void initState() {
    super.initState();
    
    _vlcService = VlcService(streamUrl);
    _vlcService.controller.addListener(() {
      setState(() {}); 
    });
    _conectivityService = ConectivityService(_vlcService);
    
    _conectivityService.startMonitoringNetwork(context);
    _initializeVolume();

    setState(() {});
  }

  @override
  void dispose() {

    super.dispose();
    _vlcService.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final showDialog = Showdialog();
    final listDrawer = ListDrawer();
    final customDrawer = CustomDrawer(showDialog, listDrawer);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: primaryColor,
        ),
        backgroundColor: backgroundColor,
      ),
      drawer: customDrawer.customdrawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.width * 0.7,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(logoPath),
                  fit: BoxFit.cover,
                ),
              ),
              child: VlcPlayer(
                controller: _vlcService.controller,
                aspectRatio: 16 / 9,
                virtualDisplay: true,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.4,
              child: Row(
                children: [
                  const Icon(Icons.volume_down, color: disableColor),
                  Expanded(
                    child: Slider(
                      min: 0,
                      max: 1,
                      activeColor: primaryColor,
                      inactiveColor: secondaryColor,
                      onChanged: _vlcService.controller.value.isPlaying
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
                  const Icon(Icons.volume_up, color: disableColor),
                ],
              ),
            ),
            SizedBox(
              child: IconButton(
                icon: Icon(
                  _vlcService.controller.value.isPlaying
                      ? Icons.pause_circle_filled
                      : Icons.play_circle_filled,
                  size: 64,
                  color: primaryColor,
                ),
                onPressed: () {
                  setState(() {
                    if (_vlcService.controller.value.isPlaying) {
                      _vlcService.stop();          
                      playing = false;                        
                    } else {                    
                      _conectivityService.attemptReconnection();
                      playing =true;
                    }
                  });
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
