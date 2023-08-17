import 'package:flutter/material.dart';

class AudioPlayerModel with ChangeNotifier {
  bool _playing = false;

  Duration _songDuration = const Duration(milliseconds: 0);
  Duration _currentDuration = const Duration(milliseconds: 0);

  // int get duractionSong => _songDuration.inSeconds;
  String get songTotalDuration => printDuration(_songDuration);
  String get currentSeconds => printDuration(_currentDuration);

  double get porcentaje => (_songDuration.inSeconds > 0)
      ? _currentDuration.inSeconds / _songDuration.inSeconds
      : 0;
  late AnimationController _controller;
  AnimationController get controller => _controller;

  set controller(AnimationController ctr) {
    _controller = ctr;
  }

  bool get playing => _playing;
  set playing(bool valor) {
    _playing = valor;
    notifyListeners();
  }

  Duration get songDuration => _songDuration;
  set songDuration(Duration valor) {
    _songDuration = valor;
    notifyListeners();
  }

  Duration get currentDuration => _currentDuration;
  set currentDuration(Duration valor) {
    _currentDuration = valor;
    notifyListeners();
  }

  String printDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
// assets_audio_player


/*
assetAudioPlayer.open(
      Audio('assets/Breaking-Benjamin-Far-Away.mp3'),
      autoStart: true,
      showNotification: true
);



En el video verán:

audioPlayerModel.songDuration = playingAudio.duration;
Ahora es:

audioPlayerModel.songDuration = playingAudio?.audio.duration ?? Duration(seconds: 0);*/