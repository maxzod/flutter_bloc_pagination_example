import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:pagination/entities/movie.dart';

part 'home_state.dart';

final _dio = Dio(
  BaseOptions(
    baseUrl: 'http://api.themoviedb.org/3/',
    validateStatus: (_) => true,
  ),
);

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading()) {
    refresh();
  }
  int _pageNo = 0;
  bool _canLoadMore = true;
  bool get canLoadMore => _canLoadMore;
  final _movies = <MovieEntity>[];

  Future<void> refresh() async {
    log('refresh()');
    _pageNo = 0;
    _canLoadMore = true;
    _movies.clear();
    loadMore();
  }

  Future<void> loadMore() async {
    if (!_canLoadMore) return;
    try {
      log('now i will load page ${_pageNo + 1}');
      emit(_pageNo == 0 ? HomeLoading() : HomeLoadingMore(_movies));

      await Future.delayed(Duration(seconds: 2));

      final response = await _dio.get(
        'discover/movie',
        queryParameters: {
          'api_key': 'acea91d2bff1c53e6604e4985b6989e2',
          'page': ++_pageNo,
        },
      );
      if (response.statusCode != HttpStatus.ok && response.data != 'success') throw response.data['status_message'];
      final dataList = (response.data['results'] as List).map((e) => MovieEntity.fromMap(e)).toList();
      log('$_pageNo loaded with ${dataList.length} movie ! ');

      if (dataList.isEmpty) {
        _canLoadMore = false;
      }
      _movies.addAll(dataList);
      emit(HomeLoaded(_movies));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
