import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/messages.dart';
import '../../../domain/models/post.dart';
import '../../../domain/use_cases/add_post.dart';
import '../../../domain/use_cases/delete_post.dart';
import '../../../domain/use_cases/update_post.dart';

part 'operations_event.dart';

part 'operations_state.dart';

class OperationsBloc extends Bloc<OperationsEvent, OperationsState> {
  final AddPost addPost;
  final DeletePost deletePost;
  final UpdatePost updatePost;

  OperationsBloc({required this.addPost,
    required this.deletePost,
    required this.updatePost})
      : super(OperationsInitial()) {
    on<OperationsEvent>((event, emit) async {
      if (event is AddPostEvent) {
        emit(LoadingState());
        final response = await addPost.invoke(event.post);
        response.fold((failure) =>
            emit(ErrorState(message: _mapFailureToMessage(failure))), (
            success) => emit(MessageState(message: ADD_SUCCESS_MESSAGE)));
      }

      if (event is UpdatePostEvent) {
        emit(LoadingState());
        final response = await updatePost.invoke(event.post);
        response.fold((failure) =>
            emit(ErrorState(message: _mapFailureToMessage(failure))), (
            success) => emit(MessageState(message: UPDATE_SUCCESS_MESSAGE)));
      }

      if (event is DeletePostEvent) {
        emit(LoadingState());
        final response = await deletePost.invoke(event.postId);
        response.fold((failure) =>
            emit(ErrorState(message: _mapFailureToMessage(failure))), (
            success) => emit(MessageState(message: DELETE_SUCCESS_MESSAGE)));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case NetworkFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }

}
