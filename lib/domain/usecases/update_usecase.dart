
import 'package:dartz/dartz.dart';
import 'package:todo_list_app/data/models/remote_model.dart';
import 'package:todo_list_app/domain/repositories/remote_repository.dart';

import '../../core/error/failure.dart';

class UpdatePost {
  final RemoteRepository repository;

  UpdatePost(this.repository);

  Future<Either<Failure, RemoteModel>> call(int id, RemoteModel post) async {
    return await repository.updatePost(id, post);
  }
}