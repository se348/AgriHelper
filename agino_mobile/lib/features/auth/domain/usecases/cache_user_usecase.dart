import 'package:agino_mobile/core/error/failure.dart';
import 'package:agino_mobile/core/usecase/usecase.dart';
import 'package:agino_mobile/features/auth/domain/entities/user.dart';
import 'package:agino_mobile/features/auth/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class CacheUserUsecase implements UseCase<int, User> {
  final UserRepository userRepository;

  CacheUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, int>> call(User user) async {
    return await userRepository.cacheUser(user);
  }
}
