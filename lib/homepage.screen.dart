import 'package:flutter/material.dart';
import 'package:movie_app/search.controller.dart';
import 'package:movie_app/text.widget.dart';
import 'package:provider/provider.dart';
import 'moviecard.widget.dart';

class MoviesHomePage extends StatelessWidget {
  MoviesHomePage({super.key});
  final decoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(7),
    boxShadow: const [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 2,
        spreadRadius: 2,
      )
    ],
  );
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 40,
                      decoration: decoration,
                      child: Consumer<SearchController>(
                        builder: (context, searchCtr, child) {
                          return TextFormField(
                            controller: searchController,
                            cursorColor: Colors.black,
                            onChanged: (value) {
                              searchCtr.updateSearchText(value);
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                splashRadius: 0.1,
                                onPressed: () {
                                  searchController.clear();
                                  searchCtr.updateSearchText("");
                                },
                                icon: Icon(
                                  Icons.clear,
                                  color: Colors.black,
                                  size: searchController.text != "" ? 20 : 0,
                                ),
                              ),
                              hintText: 'Search',
                              contentPadding: const EdgeInsets.only(
                                top: 7,
                                bottom: 10,
                                left: 10,
                                right: 10,
                              ),
                              border: InputBorder.none,
                            ),
                          );
                        },
                      )),
                ),
                Container(
                  height: 40,
                  padding: const EdgeInsets.all(7),
                  decoration: decoration,
                  child: const Icon(Icons.search),
                )
              ],
            ),
            displayText(
              "Popular Movies",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              bottomPadding: 14,
              topPadding: 14,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: 192,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return displaymovieCard(
                  image:
                      "https://images.unsplash.com/photo-1608186336271-53313eeaf864?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
                  moviename: "Avatar 2.0",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
