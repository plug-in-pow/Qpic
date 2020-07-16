import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ai_captioner/components/photo_filter/photo_filter_s1.dart';
import 'package:smart_ai_captioner/components/photo_fusion/photo_fusion_s1.dart';
import 'package:smart_ai_captioner/provider/filter_provider.dart';
import 'package:smart_ai_captioner/provider/fusion_provider.dart';

class TabModel {
  String iconPath;
  String title;
  String descr;
  Color color, textColor;
  Widget screen;

  TabModel(
      {this.iconPath,
      this.title,
      this.descr,
      this.color,
      this.textColor,
      this.screen});

  void setIconPath(String getIconPath) {
    iconPath = getIconPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDescr(String getDescr) {
    descr = getDescr;
  }

  void setColor(Color getColor) {
    color = getColor;
  }

  void setTextColor(Color getTextColor) {
    textColor = getTextColor;
  }

  void setScreen(Widget getScreen) {
    screen = getScreen;
  }

  String getIconPath() {
    return iconPath;
  }

  String getTitle() {
    return title;
  }

  String getDescr() {
    return descr;
  }

  Color getColor() {
    return color;
  }

  Color getTextColor() {
    return textColor;
  }

  Widget getScreen() {
    return screen;
  }
}

List<TabModel> getTabs() {
  List<TabModel> tabs = new List<TabModel>();
  TabModel tabModel = new TabModel();

  tabModel = new TabModel();
  tabModel.setIconPath('assets/icons/disc.png');
  tabModel.setTitle('Photo Fusion');
  tabModel.setDescr(
      'Combine Your image with the available artwork to get the ' +
          'artistic image out of it. Try it now !!');
  tabModel.setColor(Color(0xff424A9A));
  tabModel.setTextColor(Colors.white);
  tabModel.setScreen(ChangeNotifierProvider(
    create: (BuildContext context) => FusionImageData(),
    child: PhotoFusionS1(),
  ));
  tabs.add(tabModel);

  tabModel = new TabModel();
  tabModel.setIconPath('assets/icons/filter.png');
  tabModel.setTitle('Photo Filter');
  tabModel.setDescr(
      'Apply various filter to your photo ' + 'to make it look good !!');
  tabModel.setColor(Color(0xfff3f6fb));
  tabModel.setTextColor(Colors.black);
  tabModel.setScreen(ChangeNotifierProvider(
    create: (BuildContext context) => ImageData(),
    child: PhotoFilterS1(),
  ));
  tabs.add(tabModel);

  return tabs;
}
