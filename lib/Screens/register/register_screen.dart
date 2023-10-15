import 'dart:io';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shop_app/Screens/login/login_screen.dart';
import 'package:shop_app/Screens/register/cubit/cubit.dart';
import 'package:shop_app/Screens/register/cubit/state.dart';



import '../../shared/components/components.dart';


class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var taxController = TextEditingController();

  var passwordController = TextEditingController();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  File? profileImage;
  var pickerController = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
       listener: (context, state) {
        if (state is RegisterSuccessState) {
          navigateAndFinish(context, LoginScreen());
        }
      },
      builder: (context, state) {
        return Scaffold(

          body: Container(
        decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/loginn.jpg'),fit: BoxFit.cover),),
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(children: [
                      defaultTextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        prefix: Icons.person,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter gallery name';
                          }
                          return null;
                        },
                        label: 'gallery name',
                        hint: 'Enter your gallery name',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                        controller: taxController,
                        keyboardType: TextInputType.number,

                        prefix: Icons.email,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter Tax File Number';
                          }
                          return null;
                        },
                        label: 'Tax File Number',
                        hint: 'Enter your Tax File Number',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        prefix: Icons.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter phone';
                          }
                          return null;
                        },
                        label: 'Phone',
                        hint: 'Enter your phone',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefix: Icons.email,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        label: 'Email',
                        hint: 'Enter your email',
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      defaultTextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        prefix: Icons.key,
                        suffix: RegisterCubit.get(context).suffix,
                        isPassword: RegisterCubit.get(context).isPassword,
                        suffixPressed: () {
                          RegisterCubit.get(context).changePassword();
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        label: 'Password',
                        hint: 'Enter your password',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! CreateUserInitialState,
                        builder: (context) => Center(
                          child: defaultMaterialButton(
                             function: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  tax_number: taxController.text,
                                );
                              }
                             },
                            text: 'Register',
                            radius: 20,
                          ),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                    ]),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
