import 'dart:io';
import 'package:wss_chat_server/server/server.dart';

void main() async {
  Server.createServer(address: InternetAddress.anyIPv4).initServer();
}
