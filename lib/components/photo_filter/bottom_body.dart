import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ai_captioner/data/image_data.dart';

class BottomBody extends StatefulWidget {
  @override
  _BottomBodyState createState() => _BottomBodyState();
}

class _BottomBodyState extends State<BottomBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ImageData>(
      builder: (context, data, _) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(
              color: Colors.grey[300],
            ),
            child: data.getimageSelected()
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          debugPrint("clicked");
                          data.setFilterIndex(index);
                          data.setFilterByIndex(index);
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 70,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Center(child: Text('he')),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text("No Image Selected"),
                  ));
      },
    );
  }
}
