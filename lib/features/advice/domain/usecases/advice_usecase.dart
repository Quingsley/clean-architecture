import 'package:clean_architecture/features/advice/data/repository/advice_repo_impl.dart';
import 'package:clean_architecture/features/advice/domain/entities/advice_entity.dart';
import 'package:clean_architecture/features/advice/domain/failures/failures.dart';
import 'package:dartz/dartz.dart';

class AdviceUseCase {
  final AdviceRepositoryImpl adviceRepo;

  AdviceUseCase({required this.adviceRepo});

  Future<Either<Failure, AdviceEntity>> getAdvice() async {
    return adviceRepo.getAdviceFromDataSource();
    // can write business logic here
  }
}
