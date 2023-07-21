import 'package:equatable/equatable.dart';

/// abstract class base state
abstract class BaseState<T> extends Equatable {
  final T? data;

  const BaseState({this.data});

  @override
  List<Object?> get props => [
        data,
      ];
}

/// initialized state
class InitializedState<T> extends BaseState<T> {
  const InitializedState() : super();
}

/// unauthentication state
class UnAuthenticationState<T> extends BaseState<T> {
  const UnAuthenticationState() : super();
}

/// authenticated state
class AuthenticatedState<T> extends BaseState<T> {
  const AuthenticatedState({T? data}) : super(data: data);
}

/// loading state
class LoadingState<T> extends BaseState<T> {
  const LoadingState() : super();
}

/// empty state
class EmptyState<T> extends BaseState<T> {
  const EmptyState() : super();
}

/// loaded state
class LoadedState<T> extends BaseState<T> {
  const LoadedState({T? data}) : super(data: data);
}

/// success state
class SuccessState<T> extends BaseState<T> {
  final String? message;

  const SuccessState({T? data, this.message}) : super(data: data);

  @override
  List<Object?> get props => [data, message];
}

/// error state
class ErrorState<T> extends BaseState<T> {
  final String? message;

  const ErrorState({T? data, this.message}) : super(data: data);

  @override
  List<Object?> get props => [data, message];
}
