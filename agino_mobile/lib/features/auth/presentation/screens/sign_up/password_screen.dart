import 'package:agino_mobile/features/auth/domain/entities/user.dart';
import 'package:agino_mobile/features/auth/presentation/bloc/sign_up/sign_up_bloc.dart';
import 'package:agino_mobile/features/auth/presentation/widgets/sign_up_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../../widgets/custom_text_field.dart';

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
        },
        builder: (context, state) => Form(
          key: formKey,
          child: SignupLayout(
              disabled: true,
              onPressed: () {},
              title: "Create a password",
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // CustomTextField(textEditingController: , hintText: hintText)
                  CustomTextField(
                      type: TextInputType.visiblePassword,
                      textEditingController: passwordController,
                      visible: visible1,
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
                  CustomTextField(
                      type: TextInputType.visiblePassword,
                      textEditingController: confirmPasswordController,
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
