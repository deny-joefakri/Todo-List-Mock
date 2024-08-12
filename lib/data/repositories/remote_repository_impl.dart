
import 'package:dartz/dartz.dart';

import 'package:todo_list_app/core/error/failure.dart';

import 'package:todo_list_app/data/models/remote_model.dart';

import '../../core/error/exception.dart';
import '../../domain/repositories/remote_repository.dart';
import '../datasources/remote/remote_datasource.dart';

class RemoteRepositoryImpl extends RemoteRepository {

  final RemoteDatasource remoteDatasource;

  RemoteRepositoryImpl(this.remoteDatasource);

  @override
  Future<Either<Failure, List<RemoteModel>>> getPostList() async {
    try {
      final posts = await remoteDatasource.getPostList();
      return Right(posts);
    } catch (e) {
      return ErrorHandling.handleException(e);
    }
  }

  @override
  Future<Either<Failure, RemoteModel>> getPostById(int id) async {
    try {
      final post = await remoteDatasource.getPostById(id);
      return Right(post);
    } catch (e) {
      return ErrorHandling.handleException(e);
    }
  }

  @override
  Future<Either<Failure, RemoteModel>> createPost(RemoteModel post) async {
    try {
      final newPost = await remoteDatasource.createPost(post);
      return Right(newPost);
    } catch (e) {
      return ErrorHandling.handleException(e);
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(int id) async {
    try {
      await remoteDatasource.deletePost(id);
      return const Right(null);
    } catch (e) {
      return ErrorHandling.handleException(e);
    }
  }

  @override
  Future<Either<Failure, RemoteModel>> updatePost(int id, RemoteModel post) async {
    try {
      final newPost = await remoteDatasource.updatePost(id, post);
      return Right(newPost);
    } catch (e) {
      return ErrorHandling.handleException(e);
    }
  }

}

