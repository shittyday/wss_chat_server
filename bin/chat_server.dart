import 'dart:io';
import 'package:chat_server/server/server.dart';

void main() async {
  var chain = Platform.script.resolve('certificates/cert.pem').toFilePath();
  var key = Platform.script.resolve('certificates/key.pem').toFilePath();
  var context = SecurityContext()
    ..useCertificateChain(chain)
    ..usePrivateKey(key, password: 'secret password');
  Server.createServer(address: InternetAddress.anyIPv4, context: context)
      .initServer();
}
