import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'encrypt_message_page.dart'; // Import the EncryptMessagePage

class HideMessagePage extends StatefulWidget {
  @override
  _HideMessagePageState createState() => _HideMessagePageState();
}

class _HideMessagePageState extends State<HideMessagePage> {
  TextEditingController messageController = TextEditingController();
  String selectedEncryptionMethod = 'AES'; // Default encryption method
  String? selectedFilePath; // To store the selected file path

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hide Message in Video'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Step 2: Message Protection',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Message Input Section
            TextField(
              controller: messageController,
              decoration: InputDecoration(
                labelText: 'Enter a message',
                hintText: 'Message',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            // File Selection Button
            ElevatedButton(
              onPressed: selectFile,
              child: Text('Select Text File'),
            ),
            if (selectedFilePath != null) ...[
              SizedBox(height: 10),
              Text(
                'Selected File: $selectedFilePath',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
            ],
            SizedBox(height: 20),
            // Encryption Method Selection
            DropdownButton<String>(
              value: selectedEncryptionMethod,
              onChanged: (String? newValue) {
                setState(() {
                  selectedEncryptionMethod = newValue!;
                });
              },
              items: <String>['AES', 'DES', 'RSA', 'TEA', 'None']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            // Encode Button
            ElevatedButton(
              onPressed: encodeMessage,
              child: Text('Encode a Message'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'], // Allow only text files
    );

    if (result != null) {
      setState(() {
        selectedFilePath = result.files.single.path!;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File selection canceled.')),
      );
    }
  }


  void encodeMessage() {
    if ((messageController.text.isEmpty && (selectedFilePath == null || selectedFilePath!.isEmpty))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please either enter a message or select a file.')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EncryptMessagePage(
          message: messageController.text,
          encryptionMethod: selectedEncryptionMethod,
          filePath: selectedFilePath!,
        ),
      ),
    );
  }
}