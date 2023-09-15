import '../../../../core/presentation/theme/app_colors.dart';

import '../bloc/profile_bloc/profile_bloc.dart';
import '../../../../injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget makeTextBackgroundWhite(
      {required BuildContext context,
      required String text,
      TextAlign align = TextAlign.start}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white.withOpacity(0.3),
            border: Border.all(color: AppColors.green, width: 1.5)),
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileBloc>()..add(GetProfile()),
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is LoggedOutState) {
            context.go("/");
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.cancel_sharp,
                  color: AppColors.black,
                ),
                onPressed: () {
                  context.pop();
                },
              ),
              title: Text(
                "Profile",
                style: Theme.of(context).textTheme.bodyMedium,
              )),
          body: state is LoggedInState
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Full name",
                        style: Theme.of(context).textTheme.displayLarge,
                        textAlign: TextAlign.start,
                      ),
                      makeTextBackgroundWhite(
                          context: context, text: state.user.name!),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Email",
                        style: Theme.of(context).textTheme.displayLarge,
                        textAlign: TextAlign.start,
                      ),
                      makeTextBackgroundWhite(
                          context: context, text: state.user.email!),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Phone Number",
                        style: Theme.of(context).textTheme.displayLarge,
                        textAlign: TextAlign.start,
                      ),
                      makeTextBackgroundWhite(
                          context: context, text: state.user.phone!),
                      Container(
                        color: AppColors.white.withOpacity(0.3),
                        margin: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              child: Text(
                                "Log-out",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              onPressed: () {
                                BlocProvider.of<ProfileBloc>(context,
                                        listen: false)
                                    .add(LogoutEvent());
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : Container(),
        ),
      ),
    );
  }
}
