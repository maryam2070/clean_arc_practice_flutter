import '../models/post.dart';

abstract class PostsRepository {
  Future<List<Post>> getAllPosts();

  Future<bool> addPost(Post post);

  Future<bool> updatePost(Post post);

  Future<bool> deletePost(int id);
}
