import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:play_app/src/helpers/helpers.dart';
import 'package:play_app/src/models/audio_player_model.dart';
import 'package:play_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Background(),
          Column(
            children: [
              CustomAppBar(),
              ImagenDIscoDuracion(),
              TituloPlay(),
              Expanded(child: Lyrics())
            ],
          ),
        ],
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Container(
      width: double.infinity,
      height: screenSize.height * 0.8,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.center,
              colors: [Color(0xff33333e), Color(0xff201e28)])),
    );
  }
}

class Lyrics extends StatelessWidget {
  const Lyrics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final lyrics = getLyrics();
    return ListWheelScrollView(
      itemExtent:
          42, //увеличивает расстояние между строками, саму площадь регулирует
      diameterRatio: 1.5, //диаметр барабана
      physics: const BouncingScrollPhysics(),
      children: lyrics
          .map((linea) => Text(linea,
              style: TextStyle(
                  fontSize: 20, color: Colors.white.withOpacity(0.6))))
          .toList(),
    );
  }
}

class TituloPlay extends StatefulWidget {
  const TituloPlay({
    super.key,
  });

  @override
  State<TituloPlay> createState() => _TituloPlayState();
}

class _TituloPlayState extends State<TituloPlay>
    with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  bool firstTime = true;

  AnimationController? playerController;

  final assetAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    playerController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    super.initState();
  }

  @override
  void dispose() {
    playerController!.dispose();
    super.dispose();
  }

  void open() {
    final audioPlayerModel =
        Provider.of<AudioPlayerModel>(context, listen: false);
    assetAudioPlayer.open(Audio('assets/Breaking-Benjamin-Far-Away.mp3'),
        autoStart: true, showNotification: true);

    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayerModel.currentDuration = duration;
    });
    assetAudioPlayer.current.listen((playingAudio) {
      audioPlayerModel.songDuration =
          playingAudio?.audio.duration ?? const Duration(seconds: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Row(
          children: [
            Column(
              children: [
                Text('Far Away',
                    style: TextStyle(
                        fontSize: 30, color: Colors.white.withOpacity(0.8))),
                Text('-Breaking Benjamin-',
                    style: TextStyle(
                        fontSize: 15, color: Colors.white.withOpacity(0.5))),
              ],
            ),
            const Spacer(),
            FloatingActionButton(
                elevation: 0,
                highlightElevation: 0,
                backgroundColor: const Color(0xffF8CB51),
                onPressed: () {
                  final audioPlayerModel =
                      Provider.of<AudioPlayerModel>(context, listen: false);
                  if (isPlaying) {
                    playerController!.reverse();
                    isPlaying = false;
                    audioPlayerModel.controller.stop();
                  } else {
                    playerController!.forward();
                    isPlaying = true;
                    audioPlayerModel.controller.repeat();
                  }
                  if (firstTime) {
                    open();
                    firstTime = false;
                  } else {
                    assetAudioPlayer.playOrPause();
                  }
                },
                child: AnimatedIcon(
                    icon: AnimatedIcons.play_pause,
                    progress: playerController!))
          ],
        ));
  }
}

class ImagenDIscoDuracion extends StatelessWidget {
  const ImagenDIscoDuracion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      margin: const EdgeInsets.only(top: 80),
      child: const Row(
        children: [
          ImagenDisco(),
          SizedBox(
            width: 20,
          ),
          BarraProgresso(),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}

class BarraProgresso extends StatelessWidget {
  const BarraProgresso({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioPlayerModel>(context);
    final porcentaje = audioProvider.porcentaje;
    return Column(
      children: [
        Text(audioProvider.songTotalDuration,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.4))),
        const SizedBox(
          height: 10,
        ),
        Stack(
          children: [
            Container(
              width: 3,
              height: 230,
              color: Colors.white.withOpacity(0.1),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: 3,
                height: 230 * porcentaje,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(audioProvider.currentSeconds,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.4)))
      ],
    );
  }
}

class ImagenDisco extends StatelessWidget {
  const ImagenDisco({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final audioPlayerController = Provider.of<AudioPlayerModel>(context);
    return Container(
      padding: const EdgeInsets.all(15),
      width: 250,
      height: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200.0),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              colors: [Color(0xff484750), Color(0xff1E1C24)])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SpinPerfect(
                duration: Duration(seconds: 10),
                infinite: true,
                manualTrigger: true,
                controller: (animatedController) {
                  audioPlayerController.controller = animatedController;
                },
                child: const Image(
                    image: AssetImage(
                        'assets/aurora.jpg'))), // из пакета animate_do делает круг 360 град
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: const Color(0xff1c1c25),
                borderRadius: BorderRadius.circular(100.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
