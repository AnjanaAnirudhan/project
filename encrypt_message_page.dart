import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:convert'; // For UTF-8 encoding and decoding
import 'tea.dart';

class EncryptMessagePage extends StatelessWidget {
  final String message;
  final String encryptionMethod;
  final String filePath;

  EncryptMessagePage({
    required this.message,
    required this.encryptionMethod,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    // Encrypt the message based on the selected encryption method
    String encryptedMessage = encryptMessage(message, encryptionMethod);

    return Scaffold(
      appBar: AppBar(
        title: Text('Encrypt Message'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Encryption Method: $encryptionMethod',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Original Message:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(message),
            SizedBox(height: 20),
            Text(
              'Encrypted Message:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(encryptedMessage),
            SizedBox(height: 20),
            Text(
              'Selected File:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(filePath),
          ],
        ),
      ),
    );
  }

  String encryptMessage(String message, String method) {
    try {
      switch (method) {
        case 'AES':
        // Implement AES encryption (not shown here for brevity)
          return 'Encrypted with AES: $message';
        case 'DES':
        // Implement DES encryption (not shown here for brevity)
          return 'Encrypted with DES: $message';
        case 'RSA':
        // Implement RSA encryption (not shown here for brevity)
          return 'Encrypted with RSA: $message';
        case 'TEA':
          return _encryptWithTEA(message);
        case 'None':
        default:
          return message; // No encryption
      }
    } catch (e) {
      return 'Error encrypting message: $e';
    }
  }

  String _encryptWithTEA(String message) {
    // Convert message to a UTF-8 byte array and ensure its length is a multiple of 8
    List<int> messageBytes = utf8.encode(message);
    while (messageBytes.length % 8 != 0) {
      messageBytes.add(0); // Padding with zeroes
    }

    Uint32List data = Uint32List(2);
    List<int> encryptedMessage = [];

    TEA tea = TEA([0x12345678, 0x9abcdef0, 0x13345779, 0x5bcdef12]); // Example key

    // Encrypt each 64-bit block
    for (int i = 0; i < messageBytes.length; i += 8) {
      data[0] = _bytesToInt(messageBytes.sublist(i, i + 4));
      data[1] = _bytesToInt(messageBytes.sublist(i + 4, i + 8));

      List<int> encryptedBlock = tea.encrypt(data);
      encryptedMessage.addAll(_intToBytes(encryptedBlock[0]));
      encryptedMessage.addAll(_intToBytes(encryptedBlock[1]));
    }

    return base64.encode(encryptedMessage); // Return encrypted message as base64 string
  }

  // Helper function to convert bytes to an integer
  int _bytesToInt(List<int> bytes) {
    return (bytes[0] << 24) |
    (bytes[1] << 16) |
    (bytes[2] << 8)  |
    (bytes[3]);
  }

  // Helper function to convert an integer to bytes
  List<int> _intToBytes(int value) {
    return [
      (value >> 24) & 0xFF,
      (value >> 16) & 0xFF,
      (value >> 8)  & 0xFF,
      value & 0xFF
    ];
  }
}
