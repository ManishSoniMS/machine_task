part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;

  const factory AuthState.authenticating() = _Authenticating;

  const factory AuthState.authenticated(AuthUser user) = Authenticated;

  const factory AuthState.unauthenticated() = _UnAuthenticated;

  const factory AuthState.error(Failure failure) = _Error;
}
