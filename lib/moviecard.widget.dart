import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widget.dart';

displaymovieCard({
  double height = 200.0,
  width = 160.0,
  padding = 7.0,
  borderRadius = 14.0,
  imageHeight = 200.0 - 50.0,
  Color color = Colors.white,
  String? image,
  moviename,
}) {
  print("Oooooooooook $moviename");
  final loadingWidget = Container(
    alignment: Alignment.center,
    height: imageHeight,
    child: const CupertinoActivityIndicator(),
  );

  return Container(
    height: height,
    width: width,
    padding: EdgeInsets.all(padding),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 2,
          spreadRadius: 3.4,
        )
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(7),
          child: image != null
              ? Image.network(
                  image,
                  height: imageHeight,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return loadingWidget;
                    }
                    return Center(
                      child: child,
                    );
                  },
                )
              : loadingWidget,
        ),
        moviename != null
            ? displayText(
                " $moviename",
                topPadding: 7.0,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: LinearProgressIndicator(
                  minHeight: 30,
                  color: Colors.white54,
                  backgroundColor: Colors.grey[100],
                ),
              )
      ],
    ),
  );
}
