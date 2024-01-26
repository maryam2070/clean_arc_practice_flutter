
import 'package:clean_arc_practice/features/posts/domain/repository/posts_repository.dart';

import '../models/post.dart';

class AddPost{
  final PostsRepository repo;

  AddPost(this.repo);


  Future<bool> invoke(Post post)async{
    return await repo.addPost(post);
  }
}