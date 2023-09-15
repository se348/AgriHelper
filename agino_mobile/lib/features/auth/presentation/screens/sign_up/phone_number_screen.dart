import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../injection_container.dart';
import '../../../domain/entities/user.dart';
import '../../bloc/sign_up/sign_up_bloc.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/sign_up_layout.dart';

class PhoneNumberScreen extends StatefulWidget {
  PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  
   

  void countryPicker(BuildContext context) {
    showCountryPicker(
      context: context,
      showPhoneCode:
          true, // optional. Shows phone code before the country name.
      onSelect: (Country currCountry) {
        setState(() {
          country = currCountry;
          countryController.text =
              "${currCountry.displayNameNoCountryCode} (+${currCountry.phoneCode})";
        });
        ;
      },
    );
  }

  Widget countryCodeSelector(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: countryController,
      onTap: () {
        countryPicker(context);
      },
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: () {
                countryPicker(context);
              },
              icon: Icon(Icons.arrow_drop_down))),
    );
  }

  final TextEditingController countryController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  User? user = User();
  final formKey = GlobalKey<FormState>();

  Country? country;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SignUpBloc>()..add(GetCachedUserEvent()),
      child: BlocConsumer<SignUpBloc, SignUpState>(
        listener: (context, state) {
          if (state is UserLoadedState && state.user.phone != null) {
            setState(() {
              phoneNumberController.text = state.user.phone!.split("-")[1];
            });
          }
          if (state is UserLoadedState) {
            setState(() {
              user = state.user;
            });
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: SignupLayout(
                disabled: false,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    user?.phone =
                        "${country?.phoneCode}-${phoneNumberController.text}";
                    BlocProvider.of<SignUpBloc>(context)
                        .add(CacheSignUpEvent(user: user!));
                    context.go("/onboarding/phone/email");
                  }
                },
                title: "Sign up with your phone number",
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // CustomTextField(textEditingController: , hintText: hintText)
                    countryCodeSelector(context),
                    const SizedBox(height: 20),
                    CustomTextField(
                        type: TextInputType.phone,
                        textEditingController: phoneNumberController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              country == null) {
                            return "Please enter a valid phone number";
                          }
                          final numbersOnly = RegExp(r'^[0-9]+$');
                          if (value.length < 9 ||
                              !numbersOnly.hasMatch(value)) {
                            return "Please enter a valid phone number";
                          }
                          return null;
                        },
                        hintText: "Enter your phone number")
                  ],
                )),
          );
        },
      ),
    );
  }
}
