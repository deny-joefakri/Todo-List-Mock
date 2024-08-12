
import 'package:dartz/dartz.dart';
import 'package:todo_list_app/domain/repositories/remote_repository.dart';

import '../../core/error/failure.dart';

class DeletePost {
  final RemoteRepository repository;

  DeletePost(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.deletePost(id);
  }
}