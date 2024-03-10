
import 'package:clean_arc_practice/features/posts/domain/repository/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../models/post.dart';

class GetAllPosts{
  final PostsRepository repo;

  GetAllPosts({required this.repo});

  Future<Either<Failure,List<Post>>> invoke() async{
    return await repo.getAllPosts();
  }
}