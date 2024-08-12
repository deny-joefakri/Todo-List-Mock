import 'package:equatable/equatable.dart';

import '../../../data/models/remote_model.dart';

abstract class DetailPostState extends Equatable {
  const DetailPostState();

  @override
  List<Object> get props => [];
}

class DetailPostInitial extends DetailPostState {
  const DetailPostInitial();
}

class DetailPostLoading extends DetailPostState {
  const DetailPostLoading();
}

class DetailPostLoaded extends DetailPostState {
  final RemoteModel post;

  const DetailPostLoaded(this.post);

  @override
  List<Object> get props => [post];
}

class DetailPostError extends DetailPostState {
  final String message;

  const DetailPostError(this.message);

  @override
  List<Object> get props => [message];
}