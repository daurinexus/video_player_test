class Video {
  final int id;
  final String length;
  final String description;
  final String source;
  final String thumb;
  final String title;
  final String longDescription;

  Video({
    required this.id,
    required this.length,
    required this.description,
    required this.source,
    required this.thumb,
    required this.title,
    required this.longDescription,
  });

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      id: map['id'],
      length: map['length'],
      description: map['description'],
      source: map['sources'],
      thumb: map['thumb'],
      title: map['title'],
      longDescription: map['longDescription'],
    );
  }
}
