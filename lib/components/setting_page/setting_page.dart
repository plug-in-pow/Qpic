import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_ai_captioner/components/dialogs/about_dialog.dart';
import 'package:smart_ai_captioner/components/dialogs/policy_dialog.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            "Settings",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
        ),
        Divider(
          indent: 20.0,
          endIndent: 20.0,
        ),
        ListSettings1(),
        ListSettings2(),
        SizedBox(
          height: 40,
        ),
        Center(
          child: Text("Made in India with ❤️"),
        )
      ],
    );
  }
}

class ListSettings1 extends StatelessWidget {
  const ListSettings1({
    Key key,
  }) : super(key: key);

  Widget settingOption(String text, Function onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          "$text",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            settingOption("Clear Search History", () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setStringList('recentSearch', []);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("History Deleted Successfully"),
                duration: Duration(seconds: 2),
              ));
            }),
          ],
        ),
      ),
    );
  }
}

class ListSettings2 extends StatelessWidget {
  const ListSettings2({
    Key key,
  }) : super(key: key);

  Widget settingOption(String text, Function onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          "$text",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            settingOption("Terms & Conditions", () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return PolicyDialog(
                      mdFileName: 'terms_and_condition.md',
                    );
                  });
            }),
            settingOption("Privacy Policy", () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return PolicyDialog(
                      mdFileName: 'privacy_policy.md',
                    );
                  });
            }),
            settingOption("More info", () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AboutDilogePage();
                  });
            })
          ],
        ),
      ),
    );
  }
}
