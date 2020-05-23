import 'package:flutter/material.dart';
import 'package:smart_ai_captioner/data/grid_data.dart';

class HomeLower extends StatefulWidget {
  @override
  _HomeLowerState createState() => _HomeLowerState();
}

class _HomeLowerState extends State<HomeLower> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: MediaQuery.of(context).size.height * 0.35,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0))),
        child: GridList(),
      ),
    );
  }
}

class GridList extends StatefulWidget {
  @override
  _GridListState createState() => _GridListState();
}

class _GridListState extends State<GridList> {
  List<GridModel> grids = new List<GridModel>();

  @override
  void initState() {
    super.initState();
    grids = getGrids();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GridView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: grids.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return GestureDetector(
              onTap: () {
                debugPrint("hello");
              },
              child: GridCard(imageAsset: grids[index].getImagePath()));
        },
      ),
    );
  }
}

class GridCard extends StatelessWidget {
  final String imageAsset, title;
  GridCard({this.imageAsset, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.indigoAccent),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              imageAsset,
              fit: BoxFit.fill,
            )));
  }
}
