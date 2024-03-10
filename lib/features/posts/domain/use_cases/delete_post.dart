
import 'package:clean_arc_practice/core/error/failures.dart';
import 'package:clean_arc_practice/features/posts/domain/repository/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../models/post.dart';

class DeletePost{
  final PostsRepository repo;

  DeletePost({required this.repo});


  Future<Either<Failure, Unit>> invoke(int id)async{
    return await repo.deletePost(id);
  }
}