import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AboutDilogePage extends StatefulWidget {
  @override
  _AboutDilogePageState createState() => _AboutDilogePageState();
}

class _AboutDilogePageState extends State<AboutDilogePage> {
  String appName = "Qpic";
  String version = "NA";
  void getAppInfo() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      setState(() {
        version = packageInfo.version;
      });
    } catch (e) {
      print("$e");
    }
  }

  @override
  void initState() {
    super.initState();
    getAppInfo();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      title: Text("App info"),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("App Name  :   " + appName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Version  :   " + version),
          )
        ],
      ),
    );
  }
}
