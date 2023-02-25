import 'package:flutter/material.dart';

class ImageAssets {

  static Widget appIcon() {
    var assetImage = AssetImage("assets/icons/logo-no-background.png");
    var image = Image(
      image: assetImage,
      height: 50,
      width: 50,
    );
    return Container(
      child: image,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
    );
  }

  static Widget appIcon2() {
    var assetImage = AssetImage("assets/icons/logo-no-background.png");
    var image = Image(
      image: assetImage,
      height: 150,
      width: 150,
    );
    return Container(
      child: image,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
    );
  }
}
