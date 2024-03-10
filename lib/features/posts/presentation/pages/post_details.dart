import 'package:clean_arc_practice/features/posts/domain/models/post.dart';
import 'package:clean_arc_practice/features/posts/presentation/bloc/operations/operations_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../bloc/posts/posts_bloc.dart';

class PostDetails extends StatefulWidget {
  final Post? post;

  const PostDetails({this.post, super.key});

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  @override
  Widget build(BuildContext context) {
    final _bodyController = TextEditingController();
    final _titleController = TextEditingController();
    _bodyController.text = (widget.post == null) ? "" : widget.post!.body;
    _titleController.text = (widget.post == null) ? "" : widget.post!.title;

    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<PostsBloc>(context).add(RefreshPosts());
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text((widget.post == null) ? "Add" : "Edit"),
            centerTitle: true,
            actions: [
              (widget.post==null)?Container():
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                    onTap: (){
                      BlocProvider.of<OperationsBloc>(context).add(
                          DeletePostEvent(postId: widget.post!.id));
                    },
                    child: Icon(Icons.delete)),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: BlocBuilder<OperationsBloc, OperationsState>(
              builder: (context, state) {
                if (state is MessageState) {
                  Fluttertoast.showToast(
                      msg: state.message,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blue[200],
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                return Stack(alignment: Alignment.center, children: [
                  (state is LoadingState)
                      ? CircularProgressIndicator()
                      : Container(),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _titleController,
                          onChanged: (text) {
                            _titleController.text = text;
                          },
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            hintText: "post title",
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _bodyController,
                          onChanged: (text) {
                            _bodyController.text = text;
                          },
                          textAlign: TextAlign.start,
                          maxLines: 10,
                          decoration: InputDecoration(
                            hintText: "post body",
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              if (widget.post != null) {
                                BlocProvider.of<OperationsBloc>(context).add(
                                    UpdatePostEvent(
                                        post: widget.post!.copyWith(
                                            body: _bodyController.text,
                                            title: _titleController.text)));
                              } else {
                                BlocProvider.of<OperationsBloc>(context).add(
                                    AddPostEvent(
                                        post: Post(
                                            id: 55,
                                            body: _bodyController.text,
                                            title: _titleController.text)));
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text((widget.post == null) ? "Upload" : "Edit",
                              style:  Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white
                              )),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue[200],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ]);
              },
            ),
          )),
    );
  }
}
