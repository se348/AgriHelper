import '../../../../../core/presentation/content/custom_elevated_button.dart';
import '../../../../../core/presentation/content/text_field_with_header.dart';
import '../../../domain/entities/login_entity.dart';
import '../../bloc/login_bloc/login_bloc.dart';
import '../../../../../injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>(),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is NetworkFailureState) {
            print("prob");
          }
          if (state is UserLoggedIn) {
            context.go("/farm-lists");
          }
        },
        builder: (context, state) => Scaffold(
          body: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/agino_image.png"),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset("assets/agino_logo.png"),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFieldWithHeader(
                          header: "Email",
                          hintText: "user@user.com",
                          textEditingController: emailController),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: TextFieldWithHeader(
                          header: "Password",
                          hintText: "********",
                          textEditingController: passwordController),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomElevatedButton(
                        disabled: false,
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context).add(
                              RemoteLoginEvent(
                                  user: LoginEntity(
                                      email: emailController.text,
                                      password: passwordController.text)));
                        },
                        text: "Login"),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
