import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String greetingText;

  @override
  void initState() {
    super.initState();
    greetingText = greeting();
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 60,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Good " + greetingText,
            style: TextStyle(
              fontSize: 40,
              color: Colors.indigo,
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        ListOfTabs()
      ],
    );
  }
}

class ListOfTabs extends StatefulWidget {
  @override
  _ListOfTabsState createState() => _ListOfTabsState();
}

class _ListOfTabsState extends State<ListOfTabs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Color(0xfffaa491),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const ListTile(
                trailing: Icon(Icons.album, size: 50),
                title: Text(
                  'AI Based Caption',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                subtitle: Text(
                  'Just Give us your photo and we will provide a better caption for you.' +
                      'We will try to give a better caption as much possible.',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
