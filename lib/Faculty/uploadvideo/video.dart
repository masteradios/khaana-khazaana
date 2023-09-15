import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadVideo extends StatefulWidget {
  UploadVideo({Key? key}) : super(key: key);

  @override
  State<UploadVideo> createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo> {
  _upload() async{
    try {
      firebase_storage.UploadTask uploadTask;
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('videos')
          .child('/' + selectedfile);
      uploadTask=ref.putFile(File(file.path));
      await uploadTask.whenComplete(() => null);
      String videoURL=await ref.getDownloadURL();
      print('Video URL'+videoURL);
    } catch (e) {
      print(e);
    }
  }

  String selectedfile = '';
  String filepath = '';
  late XFile file;
  _selectFile() async {
    file = (await ImagePicker().pickVideo(source: ImageSource.gallery))!;
    print('hiiiiiiiiiiiiiiiiiii' + file.name);
    if (file != null) {
      setState(() {
        selectedfile = file.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(

          appBar: AppBar
            (
            leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () { Navigator.of(context).pop(); },),
          ),
            body: Center(
      child: Column(
        children: [
          Container(
              child: selectedfile.isEmpty
                  ? Image.network(
                      'https://play-lh.googleusercontent.com/ZyWNGIfzUyoajtFcD7NhMksHEZh37f-MkHVGr5Yfefa-IX7yj9SMfI82Z7a2wpdKCA',
                      fit: BoxFit.fill,
                    )
                  : Image.network(
                      'https://cdn.pixabay.com/photo/2017/02/07/02/16/cloud-2044823_960_720.png',
                      fit: BoxFit.fill,
                    )),
          GestureDetector(
            onTap: () {
              _selectFile();
            },
            child: Text('select videos'),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                _upload();
              },
              child: Text('upload videos'),
            ),
          )
        ],
      ),
    )));
  }
}
