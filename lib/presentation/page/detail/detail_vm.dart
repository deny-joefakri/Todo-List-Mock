
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/error/failure.dart';
import '../../../data/models/remote_model.dart';
import '../../../domain/usecases/detail_usecase.dart';
import 'detail_state.dart';

class DetailPostViewModel extends ChangeNotifier {
  final GetPostById getDetailPostUseCase;

  DetailPostState _state = DetailPostInitial();
  DetailPostState get state => _state;

  DetailPostViewModel({required this.getDetailPostUseCase});

  Future<void> fetchPostDetail(int postId) async {
    _state = DetailPostLoading();
    notifyListeners();

    final Either<Failure, RemoteModel> result = await getDetailPostUseCase(postId);

    result.fold(
          (failure) {
        _state = DetailPostError(failure.message);
        notifyListeners();
      },
          (post) {
        _state = DetailPostLoaded(post);
        notifyListeners();
      },
    );
  }

}