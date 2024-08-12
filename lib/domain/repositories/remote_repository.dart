
import 'package:dartz/dartz.dart';

import '../../core/error/failure.dart';
import '../../data/models/remote_model.dart';

abstract class RemoteRepository {
  Future<Either<Failure, List<RemoteModel>>> getPostList();
  Future<Either<Failure, RemoteModel>> getPostById(int id);
  Future<Either<Failure, RemoteModel>> createPost(RemoteModel post);
  Future<Either<Failure, void>> deletePost(int id);
  Future<Either<Failure, RemoteModel>> updatePost(int id, RemoteModel post);
}