
/// Базовое иключение web сокетов приложения
abstract class SocketException implements Exception {
  SocketException(this.url, this.message);

  /// Url сокета
  final String url;

  final String message;

  @override
  String toString() => '$runtimeType $message at web socket $url';
}

/// Исключение брошенное, если произошла ошибка при попытке установить соединение с сокетом либо соединение потеряно
class SocketConnectionFailedException extends SocketException {
  SocketConnectionFailedException(String url, String message) : super(url, message);
}
