import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination/entities/movie.dart';
import 'package:pagination/modules/home/cubit/home_cubit.dart';

import 'movei_item.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies - Netfilex'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: BlocProvider.of<HomeCubit>(context).refresh,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (_, state) {
            if (state is HomeLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeError) {
              return Center(child: Text(state.msg));
            } else if (state is HomeLoaded) {
              return buildBody(state.movies, context);
            } else if (state is HomeLoadingMore) {
              return buildBody(state.movies, context, isLoadingMore: true);
            }
            throw UnimplementedError();
          },
        ),
      ),
    );
  }

  Widget buildBody(
    List<MovieEntity> movies,
    BuildContext context, {
    bool isLoadingMore = false,
  }) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (_, index) {
        final cubit = BlocProvider.of<HomeCubit>(context);
        final itemWidget = MovieItemWidget(movies[index]);
        final isLastItem = movies.length == index + 1;

        if (isLastItem && cubit.canLoadMore && !isLoadingMore) {
          cubit.loadMore();
        }
        if (isLastItem && cubit.canLoadMore && isLoadingMore) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              itemWidget,
              Center(child: CircularProgressIndicator()),
            ],
          );
        } else {
          return itemWidget;
        }
      },
    );
  }
}
