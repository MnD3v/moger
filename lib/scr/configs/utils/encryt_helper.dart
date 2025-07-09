import 'package:encrypt/encrypt.dart' as encrypt;
import 'dart:convert';

class EncryptionHelper {
 static final encrypt.Key key =
      encrypt.Key.fromUtf8("my32lengthsupersecretnooneknows1");
  final encrypt.IV iv = encrypt.IV.fromUtf8("1234567890123456");
  final encrypt.Encrypter encrypter;

  EncryptionHelper()
      : encrypter =
            encrypt.Encrypter(encrypt.AES(key));

  String encryptText(String plainText) {
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return base64UrlEncode(
        encrypted.bytes); // Utilisez base64UrlEncode pour encoder en base64URL
  }

  String? decryptText(String encryptedText) {
    try {
      final encryptedBytes = base64Decode(
          encryptedText); // Utilisez base64UrlDecode pour décoder de base64URL
      final encrypted = encrypt.Encrypted(encryptedBytes);
      final decrypted = encrypter.decrypt(encrypted, iv: iv);
      return decrypted;
    } catch (e) {
      print('Erreur lors du déchiffrement : $e');
      return null;
    }
  }
}
