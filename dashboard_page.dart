import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';
import 'hide_message_page.dart'; // Import the new page

class Dashboard extends StatefulWidget {
  @override
  _Dashboard createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard> {
  VideoPlayerController? _controller;
  File? _videoFile;

  // Function to select a video file
  Future<void> _pickVideo() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      setState(() {
        _videoFile = File(result.files.single.path!);
        _controller = VideoPlayerController.file(_videoFile!)
          ..initialize().then((_) {
            setState(() {});
            _controller!.play();
          });
      });
    }
  }

  // Function to navigate to the Hide Message Page
  Future<void> _hideMessageInVideo() async {
    if (_videoFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a video file first!')),
      );
      return;
    }

    // Navigate to the HideMessagePage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HideMessagePage()),
    );
  }

  // Placeholder function for revealing a message from a video
  Future<void> _revealMessageFromVideo() async {
    if (_videoFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a video file first!')),
      );
      return;
    }

    // Implement the actual video steganography algorithm here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Revealing message from video...')),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Stego'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _videoFile == null
                ? Text('No video selected.')
                : _controller != null && _controller!.value.isInitialized
                ? AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!),
            )
                : CircularProgressIndicator(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text('Pick a Video'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _hideMessageInVideo,
              child: Text('Hide Message in Video'),
            ),
            ElevatedButton(
              onPressed: _revealMessageFromVideo,
              child: Text('Reveal Message from Video'),
            ),
          ],
        ),
      ),
    );
  }
}
