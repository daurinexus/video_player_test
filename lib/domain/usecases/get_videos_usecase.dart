import 'package:video_list_test/domain/entities/video.dart';
import 'package:video_list_test/domain/repositories/videos_repository.dart';

class GetVideosUseCase {
  final VideosRepository _repository;

  GetVideosUseCase(this._repository);

  Future<List<Video>> call(){
    return _repository.getVideos();
  }
}