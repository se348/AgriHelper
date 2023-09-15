import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class CacheUserUsecase implements UseCase<int, User> {
  final UserRepository userRepository;

  CacheUserUsecase({required this.userRepository});

  @override
  Future<Either<Failure, int>> call(User user) async {
    return await userRepository.cacheUser(user);
  }
}
