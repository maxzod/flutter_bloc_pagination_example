part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoadingMore extends HomeState {
  final List<MovieEntity> movies;
  HomeLoadingMore(this.movies);
}

class HomeLoaded extends HomeState {
  final List<MovieEntity> movies;

  HomeLoaded(this.movies);
}

class HomeError extends HomeState {
  final String msg;

  HomeError(this.msg);
}
