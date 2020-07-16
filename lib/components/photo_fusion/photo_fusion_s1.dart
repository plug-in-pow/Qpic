import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_ai_captioner/components/error_page.dart';
import 'package:smart_ai_captioner/components/permission_handling.dart';
import 'package:smart_ai_captioner/components/photo_fusion/bottom_body_fusion.dart';
import 'package:smart_ai_captioner/components/photo_fusion/filter_body_fusion.dart';
import 'package:smart_ai_captioner/components/success_screen.dart';
import 'package:smart_ai_captioner/components/photo_fusion/Functions/save_image.dart';
import 'package:smart_ai_captioner/provider/fusion_provider.dart';

class PhotoFusionS1 extends StatefulWidget {
  @override
  _PhotoFusionS1State createState() => _PhotoFusionS1State();
}

class _PhotoFusionS1State extends State<PhotoFusionS1> {
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
          "Fusion",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: <Widget>[
          Consumer<FusionImageData>(
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
