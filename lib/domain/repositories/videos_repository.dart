import 'package:video_list_test/domain/entities/video.dart';

abstract class VideosRepository {
  Future<List<Video>> getVideos();
}