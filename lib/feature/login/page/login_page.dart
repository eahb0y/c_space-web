import 'package:c_space_web/feature/login/bloc/login_bloc.dart';
import 'package:c_space_web/feature/login/mixin/login_mixin.dart';
import 'package:c_space_web/feature/login/page/widgets/custom_text_field.dart';
import 'package:c_space_web/router/rout_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginMixin {
  @override
  void initState() {
    initController();
    super.initState();
  }

  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.pushReplacementNamed(context, RoutName.main);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const SafeArea(
                            child: SizedBox(
                          height: 70,
                        )),
                        Stack(children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Ink(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 70,
                              ),
                              child: Image.asset(
                                'assets/images/c_space.png',
                              ),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 40,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: email,
                          hintText: "Email",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: password,
                          hintText: "Password",
                          isVisible: state.isVisible,
                          suffix: GestureDetector(
                            onTap: () {
                              context.read<LoginBloc>().add(IsPasswordVisible(
                                  isVisible: state.isVisible));
                            },
                            child: state.isVisible
                                ? const Icon(Icons.remove_red_eye)
                                : const Icon(Icons.remove_red_eye_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(15),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        context.read<LoginBloc>().add(
                              SubmitEvent(
                                  password: password.text, email: email.text),
                            );
                      },
                      child: const Text("Войти"),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, RoutName.auth);
                      },
                      child: const Text("Регистрироваться"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
