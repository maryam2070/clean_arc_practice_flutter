
import 'package:clean_arc_practice/features/posts/domain/repository/posts_repository.dart';

import '../models/post.dart';

class UpdatePost{
  final PostsRepository repo;

  UpdatePost(this.repo);


  Future<bool> invoke(Post post)async{
    return await repo.updatePost(post);
  }
}