import 'package:flutter/material.dart';
import 'package:play_app/src/widgets/widgets.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [CustomAppBar(), ImagenDIscoDuracion(), TituloPlay()],
      ),
    );
  }
}

class TituloPlay extends StatelessWidget {
  const TituloPlay({
    super.key,
  });

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
                onPressed: () {},
                child: const Icon(Icons.play_arrow))
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
      padding: const EdgeInsets.symmetric(horizontal: 30),
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
    return Container(
        child: Column(
      children: [
        Text('00:00',
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
                height: 170,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text('00:00',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Colors.white.withOpacity(0.4)))
      ],
    ));
  }
}

class ImagenDisco extends StatelessWidget {
  const ImagenDisco({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
            const Image(image: AssetImage('assets/aurora.jpg')),
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
