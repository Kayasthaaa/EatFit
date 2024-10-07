enum AuthStatus { initial, loading, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final String? error;
  final Map<String, dynamic>? responseData;

  AuthState({
    required this.status,
    this.error,
    this.responseData,
  });

  factory AuthState.initial() {
    return AuthState(status: AuthStatus.initial);
  }

  factory AuthState.loading() {
    return AuthState(status: AuthStatus.loading);
  }

  factory AuthState.authenticated({Map<String, dynamic>? responseData}) {
    return AuthState(
        status: AuthStatus.authenticated, responseData: responseData);
  }

  factory AuthState.unauthenticated({String? error}) {
    return AuthState(status: AuthStatus.unauthenticated, error: error);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState && other.status == status && other.error == error;
  }

  @override
  int get hashCode => status.hashCode ^ error.hashCode;

  @override
  String toString() {
    return 'AuthState(status: $status, error: $error)';
  }
}
