import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class LogoutUsecase extends UseCase<bool, void> {
  final UserRepository userRepository;

  LogoutUsecase(this.userRepository);
  @override
  Future<Either<Failure, bool>> call(void params) async {
    return Right(await userRepository.logout());
  }
}
