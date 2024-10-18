import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ModifiedVideoPage extends StatelessWidget {
  final String modifiedVideoPath;

  ModifiedVideoPage({required this.modifiedVideoPath});

  // Function to download the video
  Future<void> _downloadVideo(BuildContext context) async {
    try {
      // Request storage permission
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("storage permission")),
        );
        return;
      }

      // Get the external storage directory to save the video
      Directory? directory = await getExternalStorageDirectory();
      if (directory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Unable to access external storage")),
        );
        return;
      }

      String newPath = "${directory.path}/downloaded_video.mp4";
      File newFile = File(newPath);

      // Check if the modified video file exists
      if (!await File(modifiedVideoPath).exists()) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Modified video file does not exist")),
        );
        return;
      }

      // Copy the video file to the new location
      await File(modifiedVideoPath).copy(newFile.path);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Video downloaded to: $newPath")),
      );
    } catch (e) {
      print("Error downloading video: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error downloading video: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modified Video'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the modified video path
            Text('Modified Video Path: $modifiedVideoPath'),

            SizedBox(height: 20),

            // Download button
            ElevatedButton.icon(
              onPressed: () => _downloadVideo(context),
              icon: Icon(Icons.download),
              label: Text("Download Video"),
            ),
          ],
        ),
      ),
    );
  }
}
