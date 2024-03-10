

import 'package:clean_arc_practice/core/navigation/routes.dart';
import 'package:clean_arc_practice/features/posts/presentation/pages/post_details.dart';
import 'package:clean_arc_practice/features/posts/presentation/pages/post_list.dart';
import 'package:flutter/cupertino.dart';

import '../../features/posts/domain/models/post.dart';

Route<dynamic> onGenerate(RouteSettings st) {
  switch (st.name) {
    case AppRoutes.postListRoute:
      {
        return CupertinoPageRoute(
            builder: (_) => const PostList(), settings: st);
      }
    case AppRoutes.postDetailsRoute:
      {
        final Post? post=st.arguments as Post?;
        return CupertinoPageRoute(
            builder: (_) =>  PostDetails(post:post), settings: st);
      }
    default:
      return CupertinoPageRoute(
          builder: (_) => const PostList(), settings: st);
  }
}
