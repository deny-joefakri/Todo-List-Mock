
import 'package:dio/dio.dart';
import 'package:todo_list_app/data/models/remote_model.dart';

import '../../../core/services/network_service.dart';

abstract class RemoteDatasource {
  Future<List<RemoteModel>> getPostList();
  Future<RemoteModel> getPostById(int id);
  Future<RemoteModel> createPost(RemoteModel post);
  Future<void> deletePost(int id);
  Future<RemoteModel> updatePost(int id, RemoteModel post);
}

class RemoteDataSourceImpl implements RemoteDatasource {

  @override
  Future<List<RemoteModel>> getPostList() async {
    final response = await apiService.get(
      'posts',
    );

    if (response.statusCode == 200) {
      final postList = response.data as List;
      return postList.map((post) => RemoteModel.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load post list');
    }
  }

  @override
  Future<RemoteModel> getPostById(int id) async {
    final response = await apiService.get(
      'posts/$id',
    );

    if (response.statusCode == 200) {
      final post = response.data;
      return RemoteModel.fromJson(post);
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  Future<RemoteModel> createPost(RemoteModel post) async {
    final response = await apiService.post(
      'posts',
      data: post.toJson(),
    );

    if (response.statusCode == 201) {
      final newPost = response.data;
      return RemoteModel.fromJson(newPost);
    } else {
      throw Exception('Failed to create post');
    }
  }

  @override
  Future<void> deletePost(int id) async {
    final response = await apiService.delete(
      'posts/$id',
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw Exception('Failed to delete post');
    }
  }

  @override
  Future<RemoteModel> updatePost(int id, RemoteModel post) async {
    final response = await apiService.put(
      'posts/$id',
      data: post.toJson(),
    );

    if (response.statusCode == 200) {
      final updatedPost = response.data;
      return RemoteModel.fromJson(updatedPost);
    } else {
      throw Exception('Failed to update post');
    }
  }

}