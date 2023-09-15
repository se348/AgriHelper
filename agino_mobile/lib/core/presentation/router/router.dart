import 'package:go_router/go_router.dart';

import '../../../features/auth/presentation/screens/login/login_screen.dart';
import '../../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../../features/auth/presentation/screens/profile_screen.dart';
import '../../../features/auth/presentation/screens/sign_up/email_screen.dart';
import '../../../features/auth/presentation/screens/sign_up/password_screen.dart';
import '../../../features/auth/presentation/screens/sign_up/phone_number_screen.dart';
import '../../../features/auth/presentation/screens/splash_screen.dart';
import '../../../features/farm/presentation/screens/create_farm_screen.dart';
import '../../../features/farm/presentation/screens/farm_list_screen.dart';
import '../../../features/farm_detail/presentation/screens/farm_detail_screen.dart';
import '../../../features/field/presentation/screens/create_field_screen.dart';
import '../../../features/field/presentation/screens/field_detail_screen.dart';
import '../../../features/sensor/presentation/screens/sensor_create_screen.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: "/",
    builder: ((context, state) => const SplashScreen()),
  ),
  GoRoute(
    path: "/profile",
    builder: ((context, state) => const ProfileScreen()),
  ),
  GoRoute(
      path: "/onboarding",
      builder: ((context, state) => const OnboardingScreen()),
      routes: [
        GoRoute(
            path: "phone",
            builder: ((context, state) => PhoneNumberScreen()),
            routes: [
              GoRoute(
                  path: "email",
                  builder: ((context, state) => const EmailScreen()),
                  routes: [
                    GoRoute(
                      path: "password",
                      builder: ((context, state) => PasswordScreen()),
                    ),
                  ]),
            ]),
        GoRoute(
          path: "login",
          builder: (context, state) => LoginScreen(),
        )
      ]),
  GoRoute(
    path: "/farm-lists",
    builder: ((context, state) => FarmListScreen()),
  ),
  GoRoute(
    path: "/create",
    builder: ((context, state) => CreateFarmScreen()),
  ),
  GoRoute(
    path: "/farm-detail/:fid",
    builder: ((context, state) => FarmDetailScreen(
          farmid: int.parse(state.pathParameters["fid"].toString()),
        )),
  ),
  GoRoute(
    path: "/create-field/:fid",
    builder: ((context, state) => CreateFieldScreen(
          farmId: int.parse(state.pathParameters["fid"].toString()),
        )),
  ),
  GoRoute(
    path: "/field-detail/:fieldId",
    builder: ((context, state) => FieldDetailScreen(
          fieldId: int.parse(state.pathParameters["fieldId"].toString()),
        )),
  ),
  GoRoute(
    path: "/create-sensor/:fieldId",
    builder: ((context, state) => SensorCreateScreen(
        fieldId: int.parse(state.pathParameters["fieldId"].toString()))),
  ),
]);
