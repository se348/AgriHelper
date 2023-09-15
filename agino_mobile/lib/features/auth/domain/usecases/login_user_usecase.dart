import '../entities/login_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/user_repository.dart';

class LoginUserUsecase implements UseCase<void, LoginEntity> {
  final UserRepository userRepository;

  LoginUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(LoginEntity user) async {
    return await userRepository.login(user);
  }
}
