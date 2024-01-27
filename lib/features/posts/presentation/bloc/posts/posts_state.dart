part of 'posts_bloc.dart';

@immutable
abstract class PostsState extends Equatable{}


class PostsInitial extends PostsState {

  @override
  List<Object?> get props => [];
}

class PostsLoading extends PostsState {
  @override
  List<Object?> get props => [];
}

class PostsError extends PostsState {
  final String message;

  PostsError(this.message);

  @override
  List<Object?> get props => [];
}

class LoadedPostsState extends PostsState {
  final List<Post> posts;

  LoadedPostsState({required this.posts});

  @override
  List<Object> get props => [posts];
}