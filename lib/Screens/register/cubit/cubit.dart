
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Screens/register/cubit/state.dart';
import 'package:shop_app/models/UserModel.dart';


class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String tax_number,

  }) {
    emit(CreateUserInitialState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
createUser(
    email: email,
    name: name,
    phone: phone,
    tax_number: tax_number,
    uId: value.user!.uid);
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }
  void createUser({
    required String email,
    required String uId,
    required String name,
    required String phone,
    required String tax_number,

  }) {
    UserModel model=UserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      tax_number: tax_number,


    );

    FirebaseFirestore.instance.collection("users").doc(uId).set(model.Tomap()).then((value) {

      emit(CreateUserSuccessState());
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePassword() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ChangePasswordRegisterState());
  }
}
