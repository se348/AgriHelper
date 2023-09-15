import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SignUpUsecase implements UseCase<void, User> {
  final UserRepository userRepository;

  SignUpUsecase({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(User user) async {
    return await userRepository.signUp(user);
  }
}
