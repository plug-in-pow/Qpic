import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photofilters/filters/preset_filters.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;
import 'package:image/image.dart' as imageLib;
import 'package:smart_ai_captioner/data/image_data.dart';

enum Source { camera, gallery }

class FilterBody extends StatefulWidget {
  @override
  _FilterBodyState createState() => _FilterBodyState();
}

class _FilterBodyState extends State<FilterBody> {
  var imageData;

  String fileName;

  final picker = ImagePicker();

  Future<void> _openDialogBox() async {
    switch (await showDialog<Source>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select Source'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Source.camera);
                },
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.camera),
                    SizedBox(
                      width: 10,
                    ),
                    const Text('Camera'),
                  ],
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, Source.gallery);
                },
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.folder),
                    SizedBox(
                      width: 10,
                    ),
                    const Text('Gallery'),
                  ],
                ),
              ),
            ],
          );
        })) {
      case Source.camera:
        getImage(ImageSource.camera);
        break;
      case Source.gallery:
        getImage(ImageSource.gallery);
        break;
    }
  }

  void getImage(ImageSource source) {
    var data = Provider.of<ImageData>(context, listen: false);
    picker.getImage(source: source).then((img) async {
      if (img != null) {
        fileName = Path.basename(img.path);
        var image = imageLib.decodeImage(await img.readAsBytes());
        data.setImage(image);
        data.setFilter(fileName, presetFiltersList[data.getFilterIndex()]);
      }
    }).catchError((err) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("$err"),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageData>(
      builder: (context, data, _) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.60,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.grey[300],
          ),
          child: data.getFilterImage().length == 0
              ? FlatButton.icon(
                  onPressed: () {
                    _openDialogBox();
                  },
                  icon: Icon(Icons.add_a_photo),
                  label: Text("Add a Photo"),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.memory(
                    data.getFilterImage(),
                    fit: BoxFit.cover,
                  ),
                ),
        );
      },
    );
  }
}
