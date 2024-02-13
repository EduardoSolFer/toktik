import 'package:flutter/material.dart';
import 'package:toktik/domain/entities/video_post.dart';
import 'package:toktik/presentation/widgets/shared/video_player/video_buttons.dart';
import '../video/fullscreen_player.dart';

class VideoScrollableView extends StatelessWidget {

  final List<VideoPost> videos;

  const VideoScrollableView({
    super.key,
    required this.videos
    });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      physics:
         BouncingScrollPhysics(), //Hacer que haga la funcion de empuje al final y al inicio
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final VideoPost videoPost = videos[index];

        return Stack(
          children: [
            SizedBox.expand(
              child: FullScreenPlayer(
                caption: videoPost.caption,
                videoUrl: videoPost.videoUrl,
              ),
            ),
            //BOTONES
            Positioned(
                bottom: 40,
                right: 20,
                child: VideoButtons(video: videoPost)
            ),
          ],
        );
      },

      //APARTADO PARA MOSTRAR CONTENEDORES DE COLORES
      //physics: const BouncingScrollPhysics(), //Hacer que haga la funcion de empuje al final y al inicio
      // scrollDirection: Axis.vertical,
      // // scrollDirection: Axis.horizontal,//Es para el recorrido de los contenedores
      //   children: [
      //     Container(
      //       color: Colors.red,
      //     ),
      //     Container(
      //       color: Colors.green,
      //     ),
      //     Container(
      //       color: Colors.blue,
      //     ),
      //     Container(
      //       color: Colors.yellow,
      //     ),
      //     Container(
      //       color: Colors.purple,
      //     )
      //   ],
    );
  }
}
