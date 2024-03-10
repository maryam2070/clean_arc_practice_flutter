

import 'package:equatable/equatable.dart';

class Post extends Equatable{

  int id;
  String title;
  String body;

  Post({required this.id,required this.title,required this.body});

  @override
  List<Object?> get props =>[id,title,body];


  Post copyWith({String? title, int? id,String? body}) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }
}