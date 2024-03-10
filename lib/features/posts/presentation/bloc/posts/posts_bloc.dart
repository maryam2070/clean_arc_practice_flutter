import 'package:bloc/bloc.dart';
import 'package:clean_arc_practice/core/error/failures.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/strings/messages.dart';
import '../../../domain/models/post.dart';
import '../../../domain/use_cases/get_all_posts.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPosts getAllPosts;

  PostsBloc({required this.getAllPosts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetPosts || event is RefreshPosts) {
        emit(PostsLoading());
        final failureOrPosts = await getAllPosts.invoke();
        failureOrPosts.fold(
            (failure) => emit(PostsError(_getMessage(failure))),
            (posts) => emit(LoadedPostsState(
                  posts: posts,
                )));
      }
    });
  }

  String _getMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case NetworkFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_ERROR_MESSAGE;
    }
  }
}
