import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../models/post.dart';

abstract class PostsRepository {
  Future<Either<Failure,List<Post>>> getAllPosts();

  Future<Either<Failure,Unit>> addPost(Post post);

  Future<Either<Failure,Unit>> updatePost(Post post);

  Future<Either<Failure,Unit>> deletePost(int id);
}
