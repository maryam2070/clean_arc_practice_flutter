import 'package:clean_arc_practice/core/error/failures.dart';
import 'package:clean_arc_practice/features/posts/data/datasources/Post_remote_data_source.dart';
import 'package:clean_arc_practice/features/posts/data/datasources/post_local_data_source.dart';

import 'package:clean_arc_practice/features/posts/domain/models/post.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repository/posts_repository.dart';
import '../models/post_model.dart';

class PostsRepositoryImpl extends PostsRepository {
  PostLocalDataSource cache;
  PostRemoteDataSource network;
  NetworkInfo networkInfo;

  PostsRepositoryImpl(
      {required this.cache, required this.network, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async{
    if (await networkInfo.isConnected()) {
      try {
        final postModel = PostModel(body: post.body,
            title: post.title,
            id:post.id);
        await network.addPost(postModel);
        return Right(unit);
      }on ServerException{
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async{
    if (await networkInfo.isConnected()) {
    try {
    await network.deletePost(id);
    return Right(unit);
    }on ServerException{
    return Left(ServerFailure());
    }
    } else {
    return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected()) {
      try {
        final posts = await network.getAllPosts();
        cache.cachePosts(posts);
        return Right(posts);
      }on ServerException{
        return Left(ServerFailure());
      }
    } else {
      try{
        final posts=await cache.getCachedPosts();
        return Right(posts);
      }on EmptyCacheException{
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    if (await networkInfo.isConnected()) {
      try {
        final postModel = PostModel(body: post.body,
        title: post.title,
        id:post.id);

       await network.updatePost(postModel);
        return Right(unit);
      }on ServerException{
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

}