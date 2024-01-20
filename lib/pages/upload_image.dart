import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:puzzlepro_app/models/sudoku.dart';
import 'package:puzzlepro_app/pages/sudoku_home.dart';

class UploadImagePage extends StatefulWidget {
  final Uint8List image;

  const UploadImagePage({super.key, required this.image});

  @override
  State<UploadImagePage> createState() => _UploadImagePageState();
}

class _UploadImagePageState extends State<UploadImagePage> {
  bool _isUploading = false;
  int _uploadProgress = 0;
  int _uploadedSize = 0;
  int _totalSize = 0;

  @override
  void initState() {
    super.initState();
    calculateUploadSize();
  }

  void calculateUploadSize() {
    setState(() {
      _totalSize = widget.image.length;
    });
    // _totalSize = widget.image.length;
  }

  Future<void> _uploadImage() async {
    setState(() {
      _isUploading = true;
      _uploadProgress = 0;
      _uploadedSize = 0;
    });
    try {
      HttpClient httpClient = HttpClient();
      // var url = 'http://10.0.2.2:8000/generate-sudoku-matrix';
      //
      // var jsonBody = {
      //   "base64_image": widget.image,
      // };
      // var body = json.encode(jsonBody);
      // var url = 'http://10.0.2.2:8000/generate-sudoku-matrix';
      // HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
      //
      // var jsonBody = {
      //   "base64_image": widget.image,
      // };
      // var body = json.encode(jsonBody);
      // var _totalSize = body.length;
      //
      // Stream<List<int>> streamUpload = http.ByteStream.fromBytes(utf8.encode(body));
      //
      // request.contentLength = _totalSize;
      //
      // request.addStream(streamUpload);
      // HttpClientResponse response = await request.close();

      var url = 'http://10.0.2.2:8000/generate-sudoku-matrix';
      String imageBase64 = base64Encode(widget.image);
      var jsonBody = {
        "base64_image": "data:image/jpg;base64,"+imageBase64
      };
      var body = json.encode(jsonBody);

      // List<List<String>> headers = [["Content-Type", "application/json"],
      //   ["Authorization", 'Basic ${base64Encode(utf8.encode('puzzleProAdmin:willBeChangedOnDeployment'))}'],
      // ];
      var totalSize = body.length;
      Stream<String> stream = Stream.value(body);

      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));

      Stream<List<int>> streamUpload =
      stream.transform(StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          _uploadedSize += data.length;
          print(data);
        },
        handleDone: (sink) {
          sink.close();
        },
        handleError: (error, stackTrace, sink) {
          throw error;
        },
      ));
      // request.headers.set(headers[0][0], headers[0][1]);
      // request.headers.set(headers[1][0], headers[1][1]);
      // request.contentLength = _totalSize;
      request.headers.set("Content-Type", "application/json", preserveHeaderCase: true);

      String authToken = 'Basic ${base64Encode(utf8.encode('puzzleProAdmin:willBeChangedOnDeployment'))}';
      request.headers.set("Authorization", authToken, preserveHeaderCase: true);
      request.add(utf8.encode(body));
      await request.addStream(streamUpload);

      HttpClientResponse response = await request.close();

      // http.Response response = await http.post(
        //   Uri.parse(url),
        //   headers: headers,
        //   body: body,
        // );
      List<List<int>> matrix;
      String jsonResponse = "someNull";
        if (response.statusCode == 200) {
          response.listen((event) => {
            jsonResponse = utf8.decode(event)
          })
          .onDone(() {
            Map<String, dynamic> parsedJson = json.decode(jsonResponse);

            List<List<int>> matrix = (json.decode(parsedJson['matrix']) as List)
                .map((row) => List<int>.from(row))
                .toList();
            if(!context.mounted)return;
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (BuildContext context) {
                      return SudokuHome(
                          sudoku: Sudoku(matrix, true, "Normal")
                      );
                    }
                )
            );
          });

        print("add data success");
      } else {
          // print(response.body);
        print("add data error");
      }
    } catch (error) {
      // Handle exception
      print('Error during image upload: $error');
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  String _calculateRemainingTime() {
    if (0 != _uploadedSize) {
      int remainingTimeInSeconds =
          ((_totalSize - _uploadedSize) / (_uploadedSize / 500)).round();
      int minutes = remainingTimeInSeconds ~/ 60;
      int seconds = remainingTimeInSeconds % 60;
      return '$minutes min $seconds sec';
    } else {
      return "--:--";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Upload Image",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 27.0,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: _uploadProgress / 100,
              minHeight: 20,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const SizedBox(height: 10),
            Text(
              '$_uploadProgress% Uploaded',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Uploaded Size: ${(_uploadedSize / (1024 * 1024)).toStringAsFixed(2)} MB',
            ),
            const SizedBox(height: 10),
            Text(
              'Total Size: ${(_totalSize / (1024 * 1024)).toStringAsFixed(2)} MB',
            ),
            // const SizedBox(height: 10),
            // Text(
            //   'Remaining Time: ${_calculateRemainingTime()}',
            // ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadImage,
              child: _isUploading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        value: _uploadProgress / 100,
                      ),
                    )
                  : const Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
