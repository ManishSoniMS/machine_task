import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_task/bloc/auth/auth_bloc.dart';
import 'package:machine_task/pages/home.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    final passwordController = TextEditingController();
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.black, width: 1));
    return Align(
      alignment: const Alignment(0, -1 / 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: emailController,
            key: const Key('loginForm_emailInput_textField'),
            decoration: InputDecoration(
              labelText: 'Email address',
              border: border,
              enabledBorder: border,
              focusedBorder: border,
            ),
          ),
          const Padding(padding: EdgeInsets.all(12)),
          TextField(
            controller: passwordController,
            key: const Key('loginForm_passwordInput_textField'),
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'password',
              border: border,
              enabledBorder: border,
              focusedBorder: border,
            ),
          ),
          const Padding(padding: EdgeInsets.all(12)),
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              state.whenOrNull(
                error: (error) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(error.message)));
                },
                authenticated: (_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                },
              );
            },
            builder: (context, state) {
              return state.maybeMap(
                orElse: () {
                  return loginButton(
                    () {
                      context.read<AuthBloc>().add(AuthEvent.login(
                          emailController.text, passwordController.text));
                    },
                  );
                },
                authenticating: (_) {
                  return loginButton(null,
                      child: const CircularProgressIndicator());
                },
              );
            },
          ),
        ],
      ),
    );
  }

  ElevatedButton loginButton(
    VoidCallback? onTap, {
    Widget child = const Text(
      'LOGIN',
      style: TextStyle(letterSpacing: 2),
    ),
  }) {
    return ElevatedButton(
      key: const Key('loginForm_continue_raisedButton'),
      onPressed: onTap,
      child: child,
    );
  }
}
