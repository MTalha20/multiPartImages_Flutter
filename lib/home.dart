import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

List multipartImages = [];
List<File>? images = [];
File? file;
final ImagePicker picker = ImagePicker();
bool isLoading = false;

void imagePick() async {
  List<XFile>? images = await picker.pickMultiImage();
  images.addAll(images);
}

Future<void> sendFiles() async {
  try {

    var uri = Uri.parse("");

    var request = new http.MultipartRequest("POST", uri);

    request.fields["name"] = "Product";
    request.fields["Specs"] = "Product Specs";

    await Future.forEach(
      images!,
      (file) async {
        request.files.add(
          http.MultipartFile(
            'files',
            (http.ByteStream(file.openRead())).cast(),
            await file.length(),
            filename: basename(file.path),
          ),
        );
      },
    );

    await request.send();
  
  } catch (e) {
    print(e.toString());
  }

}


oneImage()async{
  var length = await images![1].length();
  var stream = http.ByteStream(images![1].openRead());
  var uri = Uri.parse("");
  var request = http.MultipartRequest("", uri);
  var multipart = http.MultipartFile("files", stream, length);
  request.files.add(multipart);
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {}, child: Text("Upload")),
          ],
        ),
      ),
    );
  }
}
