import 'package:chat_application/screens/chat.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit/auth_cubit_cubit.dart';
import '../screens/auth.dart';

class Pager {
  Pager._();

  static get auth => BlocProvider(
        create: (_) => AuthCubitCubit(),
        child: const AuthScreen(),
      );

  static get chat => const ChatScreen();
}
