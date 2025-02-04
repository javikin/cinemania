class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => "API Exception: $message";
}

class NetworkException extends ApiException {
  NetworkException() : super("Network error. Please check your connection.");
}

class ServerException extends ApiException {
  ServerException() : super("Server error. Please try again later.");
}
