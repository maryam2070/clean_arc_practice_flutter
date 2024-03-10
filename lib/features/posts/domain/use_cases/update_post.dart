
import 'package:clean_arc_practice/core/error/failures.dart';
import 'package:clean_arc_practice/features/posts/domain/repository/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../models/post.dart';

class UpdatePost{
  final PostsRepository repo;

  UpdatePost({required this.repo});


  Future<Either<Failure, Unit>> invoke(Post post)async{
    return await repo.updatePost(post);
  }
}