enum WebSocketState {
  connected,
  connecting,

  /// Соединение разорвано из-за потери интернет соединения. Ожидает восстановления
  awaitingNetworkAvailability,

  /// Соединение разорвано
  disconnected,

  initial
}
