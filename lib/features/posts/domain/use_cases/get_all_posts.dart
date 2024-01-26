
import 'package:clean_arc_practice/features/posts/domain/repository/posts_repository.dart';

import '../models/post.dart';

class GetAllPosts{
  final PostsRepository repo;

  GetAllPosts(this.repo);


  Future<List<Post>> invoke()async{
    return await repo.getAllPosts();
  }
}