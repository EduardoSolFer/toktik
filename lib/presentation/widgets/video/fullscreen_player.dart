import 'package:flutter/material.dart';
import 'package:toktik/presentation/widgets/video/video_background.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatefulWidget {
  final String videoUrl;
  final String caption;

  const FullScreenPlayer(
      {super.key, required this.videoUrl, required this.caption});

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}

class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = VideoPlayerController.asset(widget.videoUrl)
      ..setVolume(0)
      ..setLooping(true) // Es el operador de cascada, hace lo mismo que lo comentado abajo
      ..play();

    // controller.setVolume(0);
    // controller.setLooping(true);
    // controller.play();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.red),
          );
        }
        return GestureDetector(
          onTap: () {
            controller.value.isPlaying
                  ? controller.pause()
                  : controller.play();
          },
          child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: Stack(
                children: [
                  VideoPlayer(controller),
          
                  // Gradiente
                  const VideoBackGround(
                    stops: [0.8, 1.0],
                  ),
          
          
                  //BOTON DE PAUSE Y PLAY
                  // Center(
                  //   child: FloatingActionButton(
                  //     onPressed:(){
                  //       setState(() {
                  //         controller.value.isPlaying
                  //         ? controller.pause()
                  //         : controller.play();
                  //       });
                  //     },
                  //     child: Icon(
                  //       controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  //     ),
                  //   ),
                  // ),
                  //Texto
                  Positioned(
                      bottom: 40,
                      left: 20,
                      child: _VideoCaption(caption: widget.caption)),
                ],
              )),
        );
      },
    );
  }
}

class _VideoCaption extends StatelessWidget {
  final String caption;
  const _VideoCaption({super.key, required this.caption});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return SizedBox(
      width: size.width * 0.8,
      child: Text(caption, maxLines: 2, style: titleStyle),
    );
  }
}
