
import 'package:dartz/dartz.dart';
import 'package:todo_list_app/data/models/remote_model.dart';
import 'package:todo_list_app/domain/repositories/remote_repository.dart';

import '../../core/error/failure.dart';

class CreatePost {
  final RemoteRepository repository;

  CreatePost(this.repository);

  Future<Either<Failure, RemoteModel>> call(RemoteModel post) async {
    return await repository.createPost(post);
  }
}