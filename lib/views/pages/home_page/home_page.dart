import 'package:flutter/material.dart';
import 'package:video_list_test/domain/entities/video.dart';
import 'package:video_list_test/views/pages/home_page/home_page_controller.dart';
import 'package:video_list_test/views/widgets/video_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageController {
  @override
  void initState() {
    super.initState();
    loadVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video List'),
      ),
      body: ValueListenableBuilder<List<Video>>(
        valueListenable: videos,
        builder: (BuildContext context, List<Video> videos, Widget? child) {
          return ListView.builder(
            itemCount: videos.length,
            itemBuilder: (context, i) {
              Video video=videos[i];
              return VideoCard(
                thumbnail: video.thumb,
                title: video.title,
                description: video.description,
                duration: video.length,
                heroImageTag: video.thumb,
                onTap: ()=>onTapVideo(context,i),
              );
            },
          );
        },
      ),
    );
  }
}
