import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ai_captioner/provider/fusion_provider.dart';
import 'package:smart_ai_captioner/provider/filter_provider.dart';
import 'package:smart_ai_captioner/data/tab_data.dart';
import 'package:smart_ai_captioner/components/photo_filter/photo_filter_s1.dart';
import 'package:smart_ai_captioner/components/photo_fusion/photo_fusion_s1.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String greetingText;
  List<TabModel> tabs = new List<TabModel>();

  @override
  void initState() {
    super.initState();
    greetingText = greeting();
    tabs = getTabs();
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

  // Filter and Fusion Screens with ChangeNotifier
  List<Widget> screens = [
    ChangeNotifierProvider(
      create: (BuildContext context) => ImageData(),
      child: PhotoFilterS1(),
    ),
    ChangeNotifierProvider(
      create: (BuildContext context) => FusionImageData(),
      child: PhotoFusionS1(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 40,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Good " + greetingText,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: Colors.indigo,
            ),
          ),
        ),

        SizedBox(
          height: 10,
        ),

        // Tab creation on HomePage for Filter and Fusion route
        ...tabs
            .map((tab) => ListOfTabs(
                iconPath: tab.getIconPath(),
                title: tab.getTitle(),
                descr: tab.getDescr(),
                color: tab.getColor(),
                textColor: tab.getTextColor(),
                screen: tab.getScreen()))
            .toList(),
      ],
    );
  }
}

class ListOfTabs extends StatelessWidget {
  final String iconPath, title, descr;
  final Color color, textColor;
  final Widget screen;
  ListOfTabs(
      {this.iconPath,
      this.title,
      this.descr,
      this.color,
      this.textColor,
      this.screen});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: color,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TabIntro(
              iconPath: iconPath,
              textColor: textColor,
              title: title,
              descr: descr,
            ),
            SizedBox(
              height: 5,
            ),
            TabButton(
              textColor: textColor,
              screen: screen,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  const TabButton({
    Key key,
    @required this.textColor,
    @required this.screen,
  }) : super(key: key);

  final Color textColor;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_forward_ios),
      color: textColor,
      splashColor: Colors.grey,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }
}

class TabIntro extends StatelessWidget {
  const TabIntro({
    Key key,
    @required this.iconPath,
    @required this.textColor,
    @required this.title,
    @required this.descr,
  }) : super(key: key);

  final String iconPath;
  final Color textColor;
  final String title;
  final String descr;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        trailing: Image.asset(
          iconPath,
          height: 50,
          color: textColor,
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        subtitle: Text(
          descr,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
