
import 'package:dartz/dartz.dart';
import 'package:todo_list_app/data/models/remote_model.dart';
import 'package:todo_list_app/domain/repositories/remote_repository.dart';

import '../../core/error/failure.dart';

class GetPostList {
  final RemoteRepository repository;

  GetPostList(this.repository);

  Future<Either<Failure, List<RemoteModel>>> call() async {
    return await repository.getPostList();
  }
}