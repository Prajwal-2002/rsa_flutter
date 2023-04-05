import 'dart:math';
import 'dart:io';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:unisys_qr_code/utils/rsa_helper.dart';

void main() {
  var keyParams = RSAKeyGeneratorParameters(BigInt.from(65537), 2048, 5);

  var secureRandom = FortunaRandom();
  var random = Random.secure();

  List<int> seeds = [];
  for (int i = 0; i < 32; i++) {
    seeds.add(random.nextInt(255));
  }

  secureRandom.seed(KeyParameter(Uint8List.fromList(seeds)));

  var rngParams = ParametersWithRandom(keyParams, secureRandom);
  var k = RSAKeyGenerator();
  k.init(rngParams);

  var keyPair = k.generateKeyPair();

  // print(RsaKeyHelper().encodePublicKeyToPem(keyPair.publicKey as RSAPublicKey));
  final publicFile = File('public.pem');
  publicFile.writeAsStringSync(
      RsaKeyHelper().encodePublicKeyToPem(keyPair.publicKey as RSAPublicKey));

  // print(RsaKeyHelper()
  //     .encodePrivateKeyToPem(keyPair.privateKey as RSAPrivateKey));
  final privateFile = File('private.pem');
  privateFile.writeAsStringSync(RsaKeyHelper()
      .encodePrivateKeyToPem(keyPair.privateKey as RSAPrivateKey));

  AsymmetricKeyParameter<RSAPublicKey> keyParametersPublic =
      PublicKeyParameter(keyPair.publicKey);
  var cipher = RSAEngine()..init(true, keyParametersPublic);

  var cipherText = cipher.process(Uint8List.fromList("Hello World".codeUnits));

  print("Encrypted: ${String.fromCharCodes(cipherText)}");
  final encrypted = File('encrypted.txt');
  encrypted.writeAsStringSync(String.fromCharCodes(cipherText));

  AsymmetricKeyParameter<RSAPrivateKey> keyParametersPrivate =
      PrivateKeyParameter(keyPair.privateKey);

  cipher.init(false, keyParametersPrivate);
  var decrypted = cipher.process(cipherText);
  print("Decrypted: ${String.fromCharCodes(decrypted)}");
}
