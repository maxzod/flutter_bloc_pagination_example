import 'package:flutter/material.dart';
import 'package:pagination/entities/movie.dart';

class MovieItemWidget extends StatelessWidget {
  final MovieEntity movie;

  const MovieItemWidget(this.movie);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(movie.poster),
      title: Text(movie.title),
      subtitle: Text(movie.overview),
      trailing: Text(movie.date),
    );
  }
}
