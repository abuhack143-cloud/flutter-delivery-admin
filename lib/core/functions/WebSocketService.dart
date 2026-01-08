import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  late WebSocketChannel channel;

  Function(Map<String, dynamic>)? onLocationReceived;
  Function()? onDisconnected; // استدعاؤه عند انقطاع الاتصال

  void connect() {
    try {
      channel = WebSocketChannel.connect(
        Uri.parse('ws://192.168.0.105:8085/companydelivery'),
        // Uri.parse('ws://194.34.232.105:8080/companydelivery'),
      );
      print("WebSocket connected");
      channel.stream.listen(
        (message) {
          print("Message from server: $message");

          final data = jsonDecode(message);
          if (onLocationReceived != null) {
            onLocationReceived!(data);
          }
        },
        onError: (error) {
          print("WebSocket Error: $error");
          if (onDisconnected != null) {
            onDisconnected!();
          }
        },
        onDone: () {
          print("WebSocket connection closed");
          if (onDisconnected != null) {
            onDisconnected!();
          }
        },
      );
    } catch (e) {
      print("Connection error: $e");
    }
  }

  void disconnect() {
    channel.sink.close();
  }
}
