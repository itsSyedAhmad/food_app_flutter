import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/repository/auth_repo.dart';

import '../models/user.dart';

enum ApiStatus { initial, loading, success, failure }

sealed class AuthEvent {}

final class SignInEvent extends AuthEvent {
  SignInEvent({required this.email, required this.password});

  final String email;
  final String password;
}

final class SignUpEvent extends AuthEvent {
  SignUpEvent({
    required this.email,
    required this.password,
    required this.fullName,
    required this.mobileNumber,
    required this.dateOfBirth,
  });

  final String email;
  final String password;
  final String fullName;
  final String mobileNumber;
  final String dateOfBirth;
}

class AuthState {
  const AuthState({
    this.status = ApiStatus.initial,
    this.user,
    this.errorMessage,
  });

  final ApiStatus status;
  final User? user;
  final String? errorMessage;
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({AuthRepo? authRepo})
    : _authRepo = authRepo ?? AuthRepo(),
      super(const AuthState()) {
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
  }

  final AuthRepo _authRepo;

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState(status: ApiStatus.loading));
    try {
      final user = await _authRepo.signIn(
        email: event.email,
        password: event.password,
      );
      emit(AuthState(status: ApiStatus.success, user: user));
    } catch (error) {
      emit(
        AuthState(status: ApiStatus.failure, errorMessage: error.toString()),
      );
    }
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState(status: ApiStatus.loading));
    try {
      final user = await _authRepo.signUp(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
        mobileNumber: event.mobileNumber,
        dateOfBirth: event.dateOfBirth,
      );
      emit(AuthState(status: ApiStatus.success, user: user));
    } catch (error) {
      emit(
        AuthState(status: ApiStatus.failure, errorMessage: error.toString()),
      );
    }
  }
}
