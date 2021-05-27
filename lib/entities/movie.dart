class MovieEntity {
  final String title;
  final String overview;
  final String date;
  final String poster;
  MovieEntity({
    required this.title,
    required this.overview,
    required this.date,
    required this.poster,
  });

  MovieEntity copyWith({
    String? title,
    String? overview,
    String? date,
    String? poster,
  }) {
    return MovieEntity(
      title: title ?? this.title,
      overview: overview ?? this.overview,
      date: date ?? this.date,
      poster: poster ?? this.poster,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'overview': overview,
      'date': date,
      'poster': poster,
    };
  }

  factory MovieEntity.fromMap(Map<String, dynamic> map) {
    return MovieEntity(
      title: map['title'] ?? 'null',
      overview: map['overview'] ?? 'null',
      date: map['release_date'] ?? 'null',
      poster: 'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/' + map['poster_path'],
    );
  }
}
