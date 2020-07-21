import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class CaptionPage extends StatefulWidget {
  final List<String> relatedTags;
  const CaptionPage({Key key, this.relatedTags}) : super(key: key);
  @override
  _CaptionPageState createState() => _CaptionPageState();
}

class _CaptionPageState extends State<CaptionPage> {
  List data;
  String message = "",
      url = "https://quotes-api-flutter-app.herokuapp.com/quotes/";
  bool isloading = true;

  Future getData() async {
    for (int i = 0; i < widget.relatedTags.length; i++) {
      var wordList = widget.relatedTags[i].split(" ");
      for (int j = 0; j < wordList.length; j++) {
        url += wordList[j] + ",";
      }
    }

    print(url);

    url += "/500";
    try {
      var response = await http
          .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

      this.setState(() {
        isloading = false;
        data = jsonDecode(response.body);
        if (data.length == 0) {
          message = "No Result Found!";
        } else {
          message = "Success!";
        }
      });
    } catch (e) {
      this.setState(() {
        isloading = false;
        message = "Error connecting to the Internet.";
      });
    }
  }

  @override
  void initState() {
    this.getData();
    super.initState();
  }

  Widget _appBar(context) {
    return AppBar(
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
      title: Text("Quotes",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          )),
    );
  }

  Widget _messageForError(message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/undraw_warning_cyit.png",
          ),
        ),
        Center(
          child: Text(
            "$message",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }

  Widget _messageForNoResult(message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/undraw_no_data_qbuo.png",
          ),
        ),
        Center(
          child: Text(
            "$message",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[800]),
          ),
        ),
      ],
    );
  }

  Widget _loader = Center(
      child: CircularProgressIndicator(
    strokeWidth: 2,
  ));

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: isloading
          ? _loader
          : data == null
              ? _messageForError(message)
              : data.length == 0 ? _messageForNoResult(message) : quotesList(),
    );
  }

  ListView quotesList() {
    return new ListView.builder(
      itemCount: data == null ? 0 : data.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: new ListTile(
                title: Text("${data[index]["author"]}"),
                subtitle: Text("${data[index]["quote"]}"),
                trailing: IconButton(
                  icon: Icon(Icons.content_copy),
                  onPressed: () {
                    Clipboard.setData(new ClipboardData(
                            text: data[index]["quote"] +
                                "  ~" +
                                data[index]["author"]))
                        .then((value) {
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("Copied to clipboard")));
                    });
                  },
                ),
              ),
            ),
            Divider()
          ],
        );
      },
    );
  }
}
