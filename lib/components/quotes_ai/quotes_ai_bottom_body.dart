import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ai_captioner/provider/quotes_ai_provider.dart';

class QuotesAiBottomBody extends StatefulWidget {
  @override
  _QuotesAiBottomBodyState createState() => _QuotesAiBottomBodyState();
}

class _QuotesAiBottomBodyState extends State<QuotesAiBottomBody> {
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            new BoxShadow(
              color: Colors.blueAccent,
              offset: new Offset(0.0, 10.0),
              blurRadius: 23.0,
            )
          ],
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          )),
      child: buildPredictionTag(),
    );
  }

  Consumer<QuotesAiImageData> buildPredictionTag() {
    return Consumer<QuotesAiImageData>(
      builder: (context, data, _) {
        return data.getImage() != null
            ? data.getRecognitions().length != 0
                ? data.getRecognitions()[0] != "Error"
                    ? predictedListView(data)
                    : Center(
                        child: Text("Failed to Process"),
                      )
                : !_isloading ? applyModelButton(data) : loadingBar()
            : Center(
                child: Text("No Image Selected"),
              );
      },
    );
  }

  Center loadingBar() {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
    );
  }

  Center applyModelButton(QuotesAiImageData data) {
    return Center(
      child: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            _isloading = true;
          });

          data.setRecognization().then((val) => {
                setState(() {
                  _isloading = false;
                })
              });
        },
        icon: Icon(Icons.arrow_forward),
        label: Text("Predict"),
      ),
    );
  }

  ListView predictedListView(QuotesAiImageData data) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          width: 5,
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: data.getRecognitions().length,
      itemBuilder: (BuildContext context, int index) {
        return Chip(
          label: Text('${data.getRecognitions()[index]}'),
        );
      },
    );
  }
}
