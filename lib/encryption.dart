import 'dart:typed_data';
import 'package:pointycastle/export.dart';

void main() {
  // generateKeyPair();
}

void generateKeyPair() {
  final cipher = AESEngine();
  final keyGen = KeyGenerator('RSA');
  final secureRandom = SecureRandom('Fortuna');
  final keyParams = RSAKeyGeneratorParameters(BigInt.parse('65537'), 2048, 12);
  keyGen.init(ParametersWithRandom(keyParams, secureRandom));
  final keyPair = keyGen.generateKeyPair();

  final publicKey = keyPair.publicKey;
  final privateKey = keyPair.privateKey;
  print('Public key: $publicKey');
  print('Private key: $privateKey');
  // final jsonWebKey = JsonWebKey.fromCryptoKeys(publicKey: publicKey, keyId: 'my-key-id');
  // final publicKeyJwk = jsonWebKey.toJson();

  // Send the publicKeyJwk to the Python Django app
  // Keep the private key secure in the Flutter app
}
