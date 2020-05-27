import 'package:flutter/material.dart';

class TabModel {
  String iconPath;
  String title;
  String descr;
  Color color, textColor;

  TabModel({this.iconPath, this.title, this.descr, this.color, this.textColor});

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
}

List<TabModel> getTabs() {
  List<TabModel> tabs = new List<TabModel>();
  TabModel tabModel = new TabModel();

  tabModel.setIconPath('assets/icons/message.png');
  tabModel.setTitle('AI caption');
  tabModel.setDescr(
      "Unable to find best caption, don't worry !! Just upload your photo " +
          "and we will provide you the best caption available.");
  tabModel.setColor(Color(0xffFC7B62));
  tabModel.setTextColor(Colors.white);
  tabs.add(tabModel);

  tabModel = new TabModel();
  tabModel.setIconPath('assets/icons/filter.png');
  tabModel.setTitle('Photo Filter');
  tabModel.setDescr(
      'Apply various filter to your photo ' + 'to make it look good !!');
  tabModel.setColor(Colors.white);
  tabModel.setTextColor(Colors.black);
  tabs.add(tabModel);

  tabModel = new TabModel();
  tabModel.setIconPath('assets/icons/disc.png');
  tabModel.setTitle('Photo Fusion');
  tabModel.setDescr(
      'Combine Your image with the available artwork to get the ' +
          'artistic image out of it. Try it now !!');
  tabModel.setColor(Color(0xff424A9A));
  tabModel.setTextColor(Colors.white);
  tabs.add(tabModel);

  return tabs;
}
