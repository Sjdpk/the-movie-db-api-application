import 'package:flutter/material.dart';
import 'package:movie_app/demo.screen.dart';
import 'package:movie_app/search.controller.dart';
import 'package:movie_app/text.widget.dart';
import 'package:provider/provider.dart';

class MovieSearch extends StatelessWidget {
  MovieSearch({super.key});
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final searchPvr = Provider.of<SearchController>(context, listen: false);
    searchPvr.searchText = "";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        title: displayText("Search"),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.all(8.0),
                child: Consumer<SearchController>(
                  builder: (context, value, child) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: TextFormField(
                        onChanged: (value) {
                          searchPvr.updateSearchText(value);
                        },
                        onFieldSubmitted: (value) {
                          if (value != "") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DemoScreen(
                                  searchQuery: value.toLowerCase(),
                                ),
                              ),
                            );
                          }
                        },
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'search movies',
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              searchController.clear();
                              searchPvr.updateSearchText("");
                            },
                            icon: Icon(
                              Icons.clear,
                              color: Colors.black,
                              size: searchPvr.searchText == "" ? 0 : 28,
                            ),
                          ),
                          filled: true,
                          fillColor: const Color(0xffd2d3f1),
                          contentPadding: const EdgeInsets.only(top: 10),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide:
                                const BorderSide(color: Color(0xffd2d3f1)),
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    );
                  },
                ),
              ),
              displayText(
                "Recent Searches",
                leftPadding: 14,
                topPadding: 30,
                bottomPadding: 10,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              )
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {},
            leading: const Icon(Icons.access_time),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              ),
            ),
            title: displayText("Avatar 2.0"),
          );
        },
      ),
    );
  }
}
