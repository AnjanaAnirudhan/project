import 'dart:io';
import 'package:flutter/material.dart';


class DecryptionResultPage extends StatelessWidget {
  final File videoFile;
  final String selectedDecryptionMethod;
  final String password;
  final String rsaPrivateKey;
  final String decryptedMessage; // Pass decrypted message

  const DecryptionResultPage({
    Key? key,
    required this.videoFile,
    required this.selectedDecryptionMethod,
    required this.password,
    required this.rsaPrivateKey,
    required this.decryptedMessage, // Decrypted message
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Decryption Result'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Decrypted Message:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(decryptedMessage), // Display the decrypted message
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}