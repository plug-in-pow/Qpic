import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:smart_ai_captioner/components/permission_handling.dart';
import 'package:smart_ai_captioner/components/photo_filter/bottom_body.dart';
import 'package:smart_ai_captioner/components/error_page.dart';
import 'package:smart_ai_captioner/components/photo_filter/filter_body.dart';
import 'package:smart_ai_captioner/components/success_screen.dart';
import 'package:smart_ai_captioner/provider/filter_provider.dart';
import 'package:smart_ai_captioner/components/photo_filter/Functions/save_image.dart';

class PhotoFilterS1 extends StatefulWidget {
  @override
  _PhotoFilterS1State createState() => _PhotoFilterS1State();
}

class _PhotoFilterS1State extends State<PhotoFilterS1> {
  @override
  Widget build(BuildContext context) {
    GlobalKey previewContainer = new GlobalKey();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
        ),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Filter",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: <Widget>[
          Consumer<ImageData>(
            builder: (context, data, _) {
              return IconButton(
                disabledColor: Colors.grey,
                icon: Icon(
                  Icons.save,
                  color: data.getImage() != null ? Colors.blue : null,
                ),
                onPressed: data.getImage() != null
                    ? () async {
                        var status = await Permission.storage.status;
                        if (await permissionHandling(
                            status, Permission.storage)) {
                          if (await saveScreen(previewContainer, context)) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => new SuccessScreen(),
                              ),
                            );
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => new ErrorScreen(),
                              ),
                            );
                          }
                        }
                      }
                    : null,
              );
            },
          ),
        ],
      ),
      body: RepaintBoundary(key: previewContainer, child: FilterBody()),
      bottomSheet: BottomBody(),
    );
  }
}
