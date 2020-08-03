import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
              tag: "Motivational", relatedTags: ['Strength', 'Victory']),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CardTiles(
              tag: "Inspirational", relatedTags: ['Inspire', 'Believe']),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CardTiles(tag: "Life", relatedTags: ['Mind', 'Family']),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CardTiles(tag: "Smile", relatedTags: ['Caring', 'Sunshine']),
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
    relatedTags.insert(0, tag);
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
            "${relatedTags[1]},${relatedTags[2]}",
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
      image: new AssetImage("assets/flame-50.png"),
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
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> recentSearch = (prefs.getStringList('recentSearch') ?? []);

        showSearch(
          context: context,
          delegate: QuoteSearch(recentSearch: recentSearch),
        );
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[200],
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

class QuoteSearch extends SearchDelegate<String> {
  List<String> recentSearch;
  QuoteSearch({@required this.recentSearch});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  void showResults(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var newList = [];
    if (recentSearch.length <= 4) {
      newList = recentSearch + [query];
    } else {
      newList = recentSearch.sublist(1) + [query];
    }
    await prefs.setStringList('recentSearch', newList);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CaptionPage(
          relatedTags: [query],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return recentSearch.length == 0
        ? buildNoHistoryContainer()
        : buildHistoryListView();
  }

  ListView buildHistoryListView() {
    return ListView.builder(
      itemCount: recentSearch.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            query = recentSearch[index];
          },
          child: ListTile(
            leading: Icon(Icons.history),
            trailing: IconButton(
                icon: Icon(Icons.call_made),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CaptionPage(
                        relatedTags: [recentSearch[index]],
                      ),
                    ),
                  );
                }),
            title: Text(recentSearch[index]),
          ),
        );
      },
    );
  }

  Container buildNoHistoryContainer() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.history,
            color: Colors.grey,
          ),
          Center(
              child: Text(
            "No Recent Search",
            style: TextStyle(
              color: Colors.grey,
            ),
          )),
        ],
      ),
    );
  }
}
