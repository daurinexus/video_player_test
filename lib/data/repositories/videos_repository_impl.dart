import 'package:video_list_test/domain/entities/video.dart';
import 'package:video_list_test/domain/repositories/videos_repository.dart';

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';

class VideosRepositoryImpl implements VideosRepository{
  @override
  Future<List<Video>> getVideos() async{
    var jsonText = await rootBundle.loadString('assets/videos.json');
    return (json.decode(jsonText) as List).map((e) => Video.fromMap(e)).toList();
  }
}