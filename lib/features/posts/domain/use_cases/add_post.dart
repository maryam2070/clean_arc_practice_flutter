
import 'package:clean_arc_practice/core/error/failures.dart';
import 'package:clean_arc_practice/features/posts/domain/repository/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../models/post.dart';

class AddPost{
  final PostsRepository repo;

  AddPost(this.repo);


  Future<Either<Failure, Unit>> invoke(Post post)async{
    return await repo.addPost(post);
  }
}