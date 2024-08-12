
import 'package:equatable/equatable.dart';
import 'package:todo_list_app/data/models/remote_model.dart';

abstract class CreateState extends Equatable {
  const CreateState();

  @override
  List<Object> get props => [];
}

class CreateInitial extends CreateState {
  const CreateInitial();
}

class CreateLoading extends CreateState {
  const CreateLoading();
}

class CreateLoaded extends CreateState {
  final RemoteModel posts;

  const CreateLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class CreateError extends CreateState {
  final String message;

  const CreateError(this.message);

  @override
  List<Object> get props => [message];
}