import 'package:flutter/material.dart';
import 'package:smart_ai_captioner/components/caption_search/caption_page.dart';

class SearchQuotePage extends StatefulWidget {
  @override
  _SearchQuotePageState createState() => _SearchQuotePageState();
}

class _SearchQuotePageState extends State<SearchQuotePage> {
  List<Widget> screens = [];
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SizedBox(height: 30),
        SearchBar(),
        SizedBox(height: 30),
        Center(
          child: Text("Popular Quote Type"),
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CardTiles(
              tag: "Motivational",
              relatedTags: ['Strength', 'Motive', 'Victory']),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CardTiles(
              tag: "Inspirational",
              relatedTags: ['Inspire', 'Passion', 'Believe']),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child:
              CardTiles(tag: "Life", relatedTags: ['Future', 'Mind', 'Family']),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CardTiles(
              tag: "Smile", relatedTags: ['Caring', 'Power', 'Sunshine']),
        )
      ],
    );
  }
}

class CardTiles extends StatefulWidget {
  final String tag;
  final List<String> relatedTags;
  const CardTiles({Key key, this.tag, this.relatedTags}) : super(key: key);

  @override
  _CardTilesState createState() => _CardTilesState();
}

class _CardTilesState extends State<CardTiles> {
  Widget quoteCard(tag, relatedTags) {
    return Container(
      height: 140.0,
      width: MediaQuery.of(context).size.width,
      margin: new EdgeInsets.only(left: 46.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 7),
          Text(
            "$tag Quotes",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 7),
          Text(
            "Related Topics : ",
            style: TextStyle(color: Colors.grey[300], fontSize: 14),
          ),
          SizedBox(height: 7),
          Text(
            "${relatedTags[0]},${relatedTags[1]},${relatedTags[2]}",
            style: TextStyle(color: Colors.grey[300], fontSize: 14),
          ),
          CardButton(
              arrowColor: Colors.white,
              screen: CaptionPage(relatedTags: relatedTags))
        ],
      ),
    );
  }

  final quoteThumbnail = Container(
    margin: new EdgeInsets.symmetric(vertical: 16.0),
    alignment: FractionalOffset.centerLeft,
    child: new Image(
      image: new AssetImage("assets/quote.png"),
      height: 92.0,
      width: 92.0,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        quoteCard(widget.tag, widget.relatedTags),
        quoteThumbnail,
      ],
    );
  }
}

class CardButton extends StatelessWidget {
  const CardButton({
    Key key,
    @required this.arrowColor,
    @required this.screen,
  }) : super(key: key);

  final Color arrowColor;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_forward_ios),
      color: arrowColor,
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

class SearchBar extends StatelessWidget {
  const SearchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[400],
        ),
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.search),
            SizedBox(
              width: 10,
            ),
            Text("Search "),
            Text("Quotes"),
          ],
        ),
      ),
    );
  }
}
