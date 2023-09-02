import 'package:agino_mobile/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../../../domain/entities/user.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/sign_up_layout.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  User? user = User();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => sl<SignUpBloc>()..add(GetCachedUserEvent()),
      child: BlocConsumer<SignUpBloc, SignUpState>(listener: (context, state) {
        if (state is UserLoadedState && state.user.email != null) {
          setState(() {
            emailController.text = state.user.email!;
            nameController.text = state.user.name!;
          });
        }
        if (state is UserLoadedState) {
          setState(() {
            user = state.user;
          });
        }
      }, builder: (context, state) {
        return Form(
          key: formKey,
          child: SignupLayout(
              disabled: false,
              onPressed: () {
                user?.name = nameController.text;
                user?.email = emailController.text;
                BlocProvider.of<SignUpBloc>(context)
                    .add(CacheSignUpEvent(user: user!));
              },
              title: "Continue creating your profile",
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // CustomTextField(textEditingController: , hintText: hintText)
                  CustomTextField(
                      type: TextInputType.emailAddress,
                      textEditingController: emailController,
                      hintText: "Enter your email address"),
                  CustomTextField(
                      type: TextInputType.name,
                      textEditingController: nameController,
                      hintText: "Enter your full name")
                ],
              )),
        );
      }),
    );
  }
}
