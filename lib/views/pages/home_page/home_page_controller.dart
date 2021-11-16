import 'package:flutter/material.dart';
import 'package:video_list_test/domain/entities/video.dart';
import 'package:video_list_test/domain/usecases/get_videos_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:video_list_test/views/pages/video_page/video_page.dart';

class HomePageController {
  ValueNotifier<List<Video>> videos = ValueNotifier([]);

  void loadVideos() async {
    GetVideosUseCase getVideos = GetIt.instance();
    List<Video> videosResult=await getVideos.call();
    videos.value=videosResult;
  }

  void onTapVideo(BuildContext context,int index){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPage(video: videos.value[index])));
  }
}
