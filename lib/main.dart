import 'package:flutter/material.dart';
import 'package:play_app/src/models/audio_player_model.dart';
import 'package:play_app/src/pages/music_player.dart';
import 'package:play_app/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AudioPlayerModel()),
      ],
      child: MaterialApp(
          theme: miTema,
          debugShowCheckedModeBanner: false,
          title: 'Music Player',
          home: const Scaffold(
            body: MusicPlayerPage(),
          )),
    );
  }
}
