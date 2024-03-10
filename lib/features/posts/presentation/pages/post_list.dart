import 'package:clean_arc_practice/core/navigation/routes.dart';
import 'package:clean_arc_practice/features/posts/domain/models/post.dart';
import 'package:clean_arc_practice/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceLocator = GetIt.instance;
    return BlocProvider(
  create: (context) => PostsBloc(getAllPosts: serviceLocator.get())..add(GetPosts()),
  child: Scaffold(
      floatingActionButton: Opacity(
        opacity: .7,
        child: FloatingActionButton(
          backgroundColor: Colors.blueAccent[100],
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.postDetailsRoute);
            //BlocProvider.of<PostsBloc>(context).
          },
          child: Icon(Icons.add),
        ),
      ),
        backgroundColor: Colors.blueAccent[100],
        body: Stack(
          children: [
            Opacity(
              opacity: .4,
              child: Container(width: double.infinity,
              height: double.infinity,
                color: Colors.white,
              ),
            ),
            Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text("Posts",style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              )),
              BlocBuilder<PostsBloc, PostsState>(
                builder: (context, state) {
                  if (state is PostsLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  } else if (state is LoadedPostsState) {
                    debugPrint(state.posts.toString());
                    return Expanded(
                      child: ListView(
                        children: state.posts
                            .map((e) => Center(child: PostItem(post: e)))
                            .toList(),
                      ),
                    );
                  } else {
                    return Text("erorr");
                  }
                },
              )
            ],
          )],
        )),
);
  }
}

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){

          Navigator.of(context).pushNamed(AppRoutes.postDetailsRoute,arguments: post);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(post.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.blueAccent)),
                  ),
                ),
                Text(post.body)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
