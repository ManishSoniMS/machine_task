import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:machine_task/models/failure.dart';
import 'package:machine_task/data/source.dart';

import '../../models/user.dart';

part 'auth_bloc.freezed.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.initial()) {
    on<_Started>(_onStarted);
    on<_Login>(_onLogin);
    on<_Logout>(_onLogout);
  }

  Future<void> _onStarted(_Started event, Emitter<AuthState> emit) async {
    final RemoteSource source = RemoteSource();

    final user = await source.isUserLoggedIn();
    if (user == null) {
      emit(const AuthState.unauthenticated());
    } else {
      emit(AuthState.authenticated(user));
    }
  }

  Future<void> _onLogin(_Login event, Emitter<AuthState> emit) async {
    final RemoteSource source = RemoteSource();

    final user = await source.login(event.email, event.password);
    if (user == null) {
      emit(const AuthState.error(
          Failure(code: "", message: "Something went wrong!")));
    } else {
      emit(AuthState.authenticated(user));
    }
  }

  Future<void> _onLogout(_Logout event, Emitter<AuthState> emit) async {
    final RemoteSource source = RemoteSource();

    await source.logout();
    emit(const AuthState.unauthenticated());
  }
}
