part of 'operations_bloc.dart';

@immutable
abstract class OperationsState {}


class OperationsInitial extends OperationsState {}

class LoadingState extends OperationsState {}

class ErrorState extends OperationsState {
  final String message;

  ErrorState({required this.message});
}

class MessageState extends OperationsState {
  final String message;

  MessageState({required this.message});
}
