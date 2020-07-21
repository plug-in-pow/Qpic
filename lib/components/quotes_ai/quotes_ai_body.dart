import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ai_captioner/components/common_widgets/alert.dart';
import 'package:smart_ai_captioner/provider/quotes_ai_provider.dart';

class QuotesAiBody extends StatefulWidget {
  @override
  _QuotesAiBodyState createState() => _QuotesAiBodyState();
}

class _QuotesAiBodyState extends State<QuotesAiBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuotesAiImageData>(
      builder: (context, data, _) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.60,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              color: data.getImage() == null
                  ? Colors.grey[300]
                  : Colors.transparent,
            ),
            child: data.getImage() != null
                ? Image.file(
                    data.getImage(),
                    fit: BoxFit.contain,
                  )
                : FlatButton.icon(
                    onPressed: () {
                      openDialogBox(context, data);
                    },
                    icon: Icon(Icons.add_a_photo),
                    label: Text(
                      "Add a Photo",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ));
      },
    );
  }
}
