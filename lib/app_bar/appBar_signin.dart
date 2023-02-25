import 'package:flutter/material.dart';

import '../image_assets.dart';

ImageAssets imageAssets = new ImageAssets();

PreferredSizeWidget appBarSignIn(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    title: ImageAssets.appIcon2(),
    elevation: 0,
    centerTitle: true,
    toolbarHeight: 85,
    actions: [
    ],
  );
}