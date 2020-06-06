import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ai_captioner/provider/filter_provider.dart';

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
            height: MediaQuery.of(context).size.height * 0.19,
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                )),
            child: data.getImage() != null
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.getFilterList().length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          data.setFilterIndex(index);
                        },
                        child: Container(
                          width: 70,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: data.getFilterIndex() == index
                                ? Border.all(color: Colors.blueAccent, width: 4)
                                : null,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: ColorFiltered(
                              colorFilter: data.getFilterList()[index],
                              child: Image.file(
                                data.getImage(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
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
