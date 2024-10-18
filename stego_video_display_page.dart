import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class StegoVideoDisplayPage extends StatelessWidget {
  final String modifiedVideoPath;

  const StegoVideoDisplayPage({
    super.key,
    required this.modifiedVideoPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stego Video Display'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Modified Stego Video:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(modifiedVideoPath),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Await the downloadVideo function since it now returns Future<void>
                await _downloadVideo(modifiedVideoPath);
              },
              child: const Text('Download Video'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Change the return type to Future<void>
  Future<void> _downloadVideo(String videoPath) async {
    try {
      // Use OpenFile to open the video file
      var result = await OpenFile.open(videoPath);
      if (result.type == ResultType.error) {
        throw Exception('Could not open file: ${result.message}');
      }
    } catch (e) {
      print('Error opening file: $e');
    }
  }
}
