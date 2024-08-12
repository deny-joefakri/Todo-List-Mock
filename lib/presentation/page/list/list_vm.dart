

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:todo_list_app/data/models/remote_model.dart';

import '../../../core/error/failure.dart';
import '../../../domain/usecases/delete_usecase.dart';
import '../../../domain/usecases/list_usecase.dart';
import 'list_state.dart';

class PostListViewModel extends ChangeNotifier {
  final GetPostList getPostListUseCase;
  final DeletePost deletePostUseCase;

  List<RemoteModel> _allPosts = [];
  List<RemoteModel> _displayedPosts = [];
  int _itemsPerPage = 10; // Number of items to load per page
  bool _isLoadingMore = false;

  PostListState _state = PostListInitial();
  PostListState get state => _state;

  List<RemoteModel> get posts => _displayedPosts; // Define the getter for posts
  bool get isLoadingMore => _isLoadingMore; // Getter for loading more state

  PostListViewModel({required this.getPostListUseCase, required this.deletePostUseCase});

  Future<void> fetchPosts() async {
    _state = const PostListLoading();
    notifyListeners();

    final Either<Failure, List<RemoteModel>> result = await getPostListUseCase();

    result.fold(
          (failure) {
        _state = PostListError(failure.message);
        notifyListeners();
      }, (posts) {
        _allPosts = posts;
        _displayedPosts = _allPosts.take(_itemsPerPage).toList();
        _state = PostListLoaded(_displayedPosts);
        notifyListeners();
      },
    );
  }

  Future<void> loadMorePosts() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;
    notifyListeners();

    // Add a delay to simulate network loading
    await Future.delayed(Duration(seconds: 1));

    final currentLength = _displayedPosts.length;
    final nextPosts = _allPosts.skip(currentLength).take(_itemsPerPage).toList();

    if (nextPosts.isNotEmpty) {
      _displayedPosts.addAll(nextPosts);
      _state = PostListLoaded(_displayedPosts);
    }

    _isLoadingMore = false;
    notifyListeners();
  }

  Future<void> deletePost(RemoteModel post) async {
    _state = PostListDeleting();
    notifyListeners();

    final result = await deletePostUseCase(post.id);

    result.fold(
          (failure) {
        _state = PostListError(failure.message);
      },
          (success) {
        _allPosts.remove(post);
        _displayedPosts = _allPosts.take(_itemsPerPage).toList();
        _state = PostListLoaded(_displayedPosts);
      },
    );

    notifyListeners();
  }

}