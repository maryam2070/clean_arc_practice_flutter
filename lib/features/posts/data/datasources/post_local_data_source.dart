import 'dart:convert';

import 'package:clean_arc_practice/core/error/exceptions.dart';
import 'package:clean_arc_practice/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource{
  Future<List<PostModel>>getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> posts);

}

class PostLocalDataSourceImpl extends PostLocalDataSource{
  Future<SharedPreferences> sp;

  PostLocalDataSourceImpl({required this.sp});

  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    List jsonList=
    posts.map
    //todo <Map<String,dynamic>>
      ((postModel) =>postModel.toJson())
        .toList();
    sp.then((sp) =>
    sp.setString("posts_key", json.encode(jsonList)) );
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    var jsonString ="";
    sp.then((sp) => jsonString = sp.getString("posts_key")! );


    if(jsonString!=null){
      List decodeJsonData = json.decode(jsonString);
      List<PostModel> jsonToPostModels = decodeJsonData
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();

      return Future.value(jsonToPostModels);
    }else{
      throw EmptyCacheException();
    }
  }

}