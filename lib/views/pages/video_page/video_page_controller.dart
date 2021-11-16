import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_list_test/domain/entities/video.dart';
import 'package:video_player/video_player.dart';

class VideoPageController {
  late VideoPlayerController videoPlayerController;
  ValueNotifier<bool> videoIsInitialized = ValueNotifier(false);

  // Animations
  late AnimationController _animationShowHideControls;
  Animation<double> get animationShowHideControls => Tween(
        begin: 0.0,
        end: 1.0,
      ).animate(_animationShowHideControls);

  late AnimationController _animationPlayPause;
  Animation<double> get animationPlayPause => Tween(
        begin: 0.0,
        end: 1.0,
      ).animate(_animationPlayPause);

  void init({
    required Video video,
    required TickerProvider vsync,
  }) async {
    _initAnimations(vsync);

    videoPlayerController = VideoPlayerController.network(video.source);
    videoPlayerController.initialize();
    await videoPlayerController.play();

    videoPlayerController.addListener(_videoPlayerListener);
  }

  void _initAnimations(TickerProvider vsync) {
    _animationShowHideControls = AnimationController(
      vsync: vsync,
      value: 0,
      duration: const Duration(milliseconds: 300),
    );
    _animationPlayPause = AnimationController(
      vsync: vsync,
      value: 0,
      duration: const Duration(milliseconds: 300),
    );
  }

  void _disposeAnimations() {
    _animationShowHideControls.stop();
    _animationShowHideControls.dispose();
  }

  void onDispose() async{
    _disposeAnimations();
    videoPlayerController.removeListener(_videoPlayerListener);
    await videoPlayerController.dispose();
  }

  void _videoPlayerListener() {
    if(!videoPlayerController.value.isBuffering && !videoIsInitialized.value){
      videoIsInitialized.value=true;
    }

    if (videoPlayerController.value.isPlaying &&
        (_animationPlayPause.status == AnimationStatus.dismissed ||
        _animationPlayPause.status == AnimationStatus.reverse)) {
          _animationPlayPause.forward();
        }
    else if(!videoPlayerController.value.isPlaying && (_animationPlayPause.status == AnimationStatus.completed ||
        _animationPlayPause.status == AnimationStatus.forward)){
          _animationPlayPause.reverse();
        }
  }

  void onTapVideo() {
    if (_animationShowHideControls.status == AnimationStatus.dismissed ||
        _animationShowHideControls.status == AnimationStatus.reverse) {
      _animationShowHideControls.forward();
    } else {
      _animationShowHideControls.reverse();
    }
  }

  Future<void> onTapPlayPause() async {
    if (videoPlayerController.value.isPlaying) {
      await videoPlayerController.pause();
    } else {
      await videoPlayerController.play();
    }
  }

  void onTapBack(BuildContext context){
    Navigator.pop(context);
  }
}
