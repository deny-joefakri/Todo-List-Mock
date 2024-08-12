

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_list_app/data/models/remote_model.dart';

import '../../../core/error/failure.dart';
import '../../../domain/usecases/create_usecase.dart';
import '../../../domain/usecases/update_usecase.dart';
import 'create_state.dart';

class CreateViewModel extends ChangeNotifier {
  final CreatePost createPostUsecase;
  final UpdatePost updatePostUsecase;

  CreateState _state = CreateInitial();
  CreateState get state => _state;

  CreateViewModel({required this.createPostUsecase, required this.updatePostUsecase});

  Future<void> createPost(RemoteModel model) async {
    _state = const CreateLoading();
    notifyListeners();

    final Either<Failure, RemoteModel> result = await createPostUsecase(model);

    result.fold(
          (failure) {
        _state = CreateError(failure.message);
        notifyListeners();
      },
          (posts) {
        _state = CreateLoaded(posts);
        notifyListeners();
      },
    );
  }

  Future<void> updatePost(RemoteModel post) async {
    _state = CreateLoading();
    notifyListeners();

    final result = await updatePostUsecase(post.id, post);

    result.fold(
          (failure) {
        _state = CreateError('Failed to update post');
        notifyListeners();
      },
          (post) {
        _state = CreateLoaded(post);
        notifyListeners();
      },
    );
  }

}