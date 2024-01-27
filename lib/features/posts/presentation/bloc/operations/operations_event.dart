part of 'operations_bloc.dart';

@immutable
abstract class OperationsEvent {}


class AddPostEvent extends OperationsEvent {
  final Post post;

  AddPostEvent({required this.post});
}


class DeletePostEvent extends OperationsEvent {
  final int postId;

  DeletePostEvent({required this.postId});
}


class UpdatePostEvent extends OperationsEvent {
  final Post post;

  UpdatePostEvent({required this.post});
}

