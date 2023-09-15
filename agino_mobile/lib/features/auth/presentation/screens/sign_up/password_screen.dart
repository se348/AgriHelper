import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../injection_container.dart';
import '../../../domain/entities/user.dart';
import '../../bloc/sign_up/sign_up_bloc.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/sign_up_layout.dart';

class PasswordScreen extends StatefulWidget {
  PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  bool? visible1 = false;
  User? user = User();
  bool? visible2 = false;
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one capital letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one small letter';
    }
    if (!value.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one symbol';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null; // Return null if the passwords match
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignUpBloc>()..add(GetCachedUserEvent()),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is UserLoadedState) {
            setState(() {
              user = state.user;
            });
          }
          if (state is NetworkFailureState) {
            const snackBar = SnackBar(
              content: Text('No network, please try again.'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is SignUpFailedState) {
            const snackBar = SnackBar(
              content: Text('Validation error'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is ServerFailureState) {
            const snackBar = SnackBar(
              content: Text('Server error, please try again later'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          if (state is RegisteredSuccessfulState) {
            const snackBar = SnackBar(
              content: Text('Registered successful'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            context.go("/farm-lists");
          }
        },
        builder: (context, state) => Form(
          key: formKey,
          child: SignupLayout(
              disabled: false,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  user?.password = passwordController.text;
                  BlocProvider.of<SignUpBloc>(context)
                      .add(RemoteSignUpEvent(user: user!));
                }
              },
              title: "Create a password",
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // CustomTextField(textEditingController: , hintText: hintText)
                  CustomTextField(
                      type: TextInputType.visiblePassword,
                      textEditingController: passwordController,
                      visible: visible1,
                      validator: _validatePassword,
                      suffix: IconButton(
                        icon: visible1 != null
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            if (visible1 != null) {
                              visible1 = null;
                              return;
                            }
                            visible1 = false;
                          });
                        },
                      ),
                      hintText: "Enter a password"),
                  const SizedBox(height: 20),
                  CustomTextField(
                      type: TextInputType.visiblePassword,
                      textEditingController: confirmPasswordController,
                      validator: _validateConfirmPassword,
                      visible: visible2,
                      suffix: IconButton(
                        icon: visible2 != null
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            if (visible2 != null) {
                              visible2 = null;
                              return;
                            }
                            visible2 = false;
                          });
                        },
                      ),
                      hintText: "Confirm the password")
                ],
              )),
        ),
      ),
    );
  }
}
