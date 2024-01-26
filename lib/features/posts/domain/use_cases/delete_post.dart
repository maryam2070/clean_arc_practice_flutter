
import 'package:clean_arc_practice/features/posts/domain/repository/posts_repository.dart';

import '../models/post.dart';

class DeletePost{
  final PostsRepository repo;

  DeletePost(this.repo);


  Future<bool> invoke(int id)async{
    return await repo.deletePost(id);
  }
}