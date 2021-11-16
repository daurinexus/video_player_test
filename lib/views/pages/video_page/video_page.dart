import 'package:flutter/material.dart';
import 'package:video_list_test/domain/entities/video.dart';
import 'package:video_list_test/views/pages/video_page/video_page_controller.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  final Video video;

  const VideoPage({
    Key? key,
    required this.video,
  }) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>
    with VideoPageController, TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    init(
      vsync: this,
      video: widget.video,
    );
  }

  @override
  void dispose() async {
    onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 300,
            child: ValueListenableBuilder<bool>(
              valueListenable: videoIsInitialized,
              builder: (BuildContext context, bool videoIsInitialized,
                  Widget? child) {
                if (videoIsInitialized) {
                  return _buildVideoPlayer();
                }
                return Stack(
                  children: [
                    Hero(
                      tag: widget.video.thumb,
                      child: Image.network(widget.video.thumb),
                    ),
                    const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ],
                );
              },
            ),
          ),
          Flexible(child: _buildInfoVideo()),
        ],
      ),
    );
  }

  Widget _buildVideoPlayer() {
    return Stack(
      children: [
        VideoPlayer(videoPlayerController),
        SizedBox.expand(
          child: GestureDetector(
            onTap: onTapVideo,
            child: AnimatedBuilder(
              animation: animationShowHideControls,
              builder: (BuildContext context, Widget? child) {
                return Container(
                  color: ColorTween(
                          begin: Colors.black.withOpacity(0.0),
                          end: Colors.black.withOpacity(0.3))
                      .animate(animationShowHideControls)
                      .value,
                  child: Opacity(
                    opacity: Tween(
                      begin: 0.0,
                      end: 1.0,
                    ).animate(animationShowHideControls).value,
                    child: Visibility(
                      visible: animationShowHideControls.value > 0.01,
                      child: SafeArea(
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 16,
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: MaterialButton(
                                  shape: const CircleBorder(),
                                  padding: EdgeInsets.zero,
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  child: const Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  onPressed: () => onTapBack(context),
                                ),
                              ),
                            ),
                            Center(
                              child: SizedBox(
                                height: 65,
                                width: 65,
                                child: MaterialButton(
                                  shape: const CircleBorder(),
                                  padding: EdgeInsets.zero,
                                  child: AnimatedIcon(
                                    icon: AnimatedIcons.play_pause,
                                    color: Colors.white,
                                    size: 60,
                                    progress: animationPlayPause,
                                    semanticLabel: 'Show menu',
                                  ),
                                  onPressed: onTapPlayPause,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoVideo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            widget.video.title,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          trailing: Text(widget.video.length),
        ),
        const Divider(height: 1),
        Flexible(
          child: SingleChildScrollView(
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(widget.video.description),
                initiallyExpanded: true,
                tilePadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                childrenPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                children: [
                  Text(widget.video.longDescription),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
