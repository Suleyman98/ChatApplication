import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit/auth_cubit_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubitCubit cubit = context.read<AuthCubitCubit>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 30,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              width: 200,
              child: Image.asset('assets/images/chat.png'),
            ),
            StreamBuilder<bool>(
                initialData: false,
                stream: cubit.loginStream.stream,
                builder: (context, snapshot) {
                  return Card(
                    margin: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: cubit.form,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter Email Adress';
                                  }
                                  return null;
                                },
                                decoration:
                                    const InputDecoration(labelText: 'Email'),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                onSaved: (newValue) {
                                  cubit.email = newValue!;
                                },
                              ),
                              TextFormField(
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter password';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                    labelText: 'Password'),
                                keyboardType: TextInputType.text,
                                autocorrect: false,
                                onSaved: (newValue) {
                                  cubit.password = newValue!;
                                },
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  cubit.submit(context);
                                },
                                child: Text(snapshot.data == true
                                    ? 'Login'
                                    : 'Sign Up'),
                              ),
                              TextButton(
                                onPressed: () {
                                  cubit.toggleAuth();
                                },
                                child: Text(snapshot.data == true
                                    ? 'Create an Account'
                                    : 'Already Have Account'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      )),
    );
  }
}
