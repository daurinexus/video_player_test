import 'package:get_it/get_it.dart';
import 'package:video_list_test/data/repositories/videos_repository_impl.dart';
import 'package:video_list_test/domain/repositories/videos_repository.dart';
import 'package:video_list_test/domain/usecases/get_videos_usecase.dart';

final getIt = GetIt.instance;

void init(){
  // Use cases
  getIt.registerLazySingleton(() => GetVideosUseCase(getIt()));

  // Repositories
  getIt.registerLazySingleton<VideosRepository>(
    () => VideosRepositoryImpl(),
  );

}