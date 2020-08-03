import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ai_captioner/components/caption_search/caption_page.dart';
import 'package:smart_ai_captioner/provider/quotes_ai_provider.dart';

class QuotesAiFloatingButton extends StatefulWidget {
  @override
  _QuotesAiFloatingButtonState createState() => _QuotesAiFloatingButtonState();
}

class _QuotesAiFloatingButtonState extends State<QuotesAiFloatingButton> {
  @override
  Widget build(BuildContext context) {
    return Consumer<QuotesAiImageData>(builder: (context, data, _) {
      return FloatingActionButton.extended(
        label: Text("Get Quotes"),
        icon: Icon(Icons.arrow_forward_ios),
        backgroundColor: data.getRecognitions().length == 0
            ? Colors.grey
            : data.getRecognitions()[0] == 'Error' ? Colors.grey : Colors.blue,
        onPressed: data.getRecognitions().length == 0
            ? null
            : data.getRecognitions()[0] == 'Error'
                ? null
                : () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CaptionPage(
                          relatedTags: data.getRecognitions(),
                        ),
                      ),
                    );
                  },
      );
    });
  }
}
