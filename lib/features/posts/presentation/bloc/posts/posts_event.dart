part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class GetPosts extends PostsEvent {}

class RefreshPosts extends PostsEvent {}


