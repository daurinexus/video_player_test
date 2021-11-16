import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final String thumbnail;
  final String title;
  final String description;
  final String? duration;
  final void Function()? onTap;
  final String? heroImageTag;

  const VideoCard({
    Key? key,
    required this.thumbnail,
    required this.title,
    required this.description,
    this.duration,
    this.onTap,
    this.heroImageTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget image = Image.network(
      thumbnail,
      height: 210,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
    );

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                if (heroImageTag != null)
                  Hero(
                    tag: heroImageTag!,
                    child: image,
                  )
                else
                  image,
                  
                if (duration != null)
                  Positioned(
                    right: 12,
                    bottom: 12,
                    child: Container(
                      height: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text(
                        duration!,
                        style: const TextStyle(color: Colors.white),
                      )),
                    ),
                  )
              ],
            ),
            const SizedBox(height: 10),
            ListTile(
              title: Text(title),
              subtitle: Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
