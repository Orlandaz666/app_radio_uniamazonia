import 'package:flutter/material.dart';
import 'package:app_radio_uniamazonia/services/vlc_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConectivityService {
 late final VlcService _vlcService;

 bool _isReconnecting = false;
  
ConectivityService(this._vlcService); 

void startMonitoringNetwork(BuildContext context) async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none &&
          _vlcService.controller.value.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sin Conexion')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Conexion Exitosa')),
        );   
          attemptReconnection(); 
      }
    });
  }

  void attemptReconnection() async {
    if (_isReconnecting) return;
    _isReconnecting = true;
    try {
      await Future.delayed(const Duration(milliseconds: 1500));
      _vlcService.stop();
      _vlcService.play();
    } finally {
      _isReconnecting = false;
    }
  }

}