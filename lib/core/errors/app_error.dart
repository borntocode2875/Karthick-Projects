/// Sealed error hierarchy for Zoho Support Hub.
///
/// The mock layer throws these; the live layer maps HTTP/API errors to them.
/// UI handles each case through [AsyncStateView].
sealed class AppError implements Exception {
  const AppError(this.message);
  final String message;
}

/// No network connectivity.
final class NetworkError extends AppError {
  const NetworkError([super.message = 'No internet connection.']);
}

/// The server returned an unexpected error (5xx).
final class ServerError extends AppError {
  const ServerError([super.message = 'Something went wrong. Try again.']);
  final int? statusCode = null;
}

/// The current user is not permitted to perform this action.
final class AuthorizationError extends AppError {
  const AuthorizationError([super.message = "This action isn't available."]);
}

/// The user is not authenticated (session expired or not signed in).
final class UnauthenticatedError extends AppError {
  const UnauthenticatedError([super.message = 'Please sign in to continue.']);
}

/// Input failed validation in the repository.
final class ValidationError extends AppError {
  const ValidationError(super.message, {this.fieldErrors = const {}});

  /// Per-field errors keyed by field key.
  final Map<String, String> fieldErrors;
}

/// The requested resource was not found.
final class NotFoundError extends AppError {
  const NotFoundError([super.message = 'Resource not found.']);
}

/// A simulated error injected by the Simulation panel in Settings.
final class SimulatedError extends AppError {
  const SimulatedError([super.message = 'Simulated error (debug only).']);
}
