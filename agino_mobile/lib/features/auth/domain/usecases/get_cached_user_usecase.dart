import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetCachedUserUsecase implements UseCase<User, NoParams> {
  final UserRepository userRepository;

  GetCachedUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await userRepository.getCachedUser();
  }
}
