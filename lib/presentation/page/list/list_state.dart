
import 'package:equatable/equatable.dart';
import 'package:todo_list_app/data/models/remote_model.dart';

abstract class PostListState extends Equatable {
  const PostListState();

  @override
  List<Object> get props => [];
}

class PostListInitial extends PostListState {
  const PostListInitial();
}

class PostListLoading extends PostListState {
  const PostListLoading();
}

class PostListLoaded extends PostListState {
  final List<RemoteModel> posts;

  const PostListLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostListError extends PostListState {
  final String message;

  const PostListError(this.message);

  @override
  List<Object> get props => [message];
}

class PostListDeleting extends PostListState {}