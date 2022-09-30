import 'package:flutter/material.dart';
import 'package:movie_app/searchdetails.screen.dart';
import 'package:movie_app/search.controller.dart';
import 'package:movie_app/text.widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                        onFieldSubmitted: (value) async {
                          if (value != "") {
                            // Obtain shared preferences.
                            final prefs = await SharedPreferences.getInstance();
                            var recentSearchList =
                                prefs.getStringList('recentsearchlist') ?? [];

                            await prefs
                                .setStringList('recentsearchlist',
                                    {...recentSearchList, value}.toList())
                                .then((_) {
                              // update provider list

                              searchPvr.updateRecentSearchList(
                                  recentSearch:
                                      {...recentSearchList, value}.toList());

                              // send to next page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DemoScreen(
                                    searchQuery: value.toLowerCase(),
                                  ),
                                ),
                              );
                            });
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
      body: FutureBuilder(
        future: getRecentSearch(context: context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          try {
            if (snapshot.hasData) {
              final snapshotData = snapshot.data;
              // return Text(snapshotData.toString());
              return Consumer<SearchController>(
                builder: (context, recentCtr, child) {
                  return ListView.builder(
                    itemCount: recentCtr.recentSearchList.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DemoScreen(
                                searchQuery: snapshotData[index].toString(),
                              ),
                            ),
                          );
                        },
                        leading: const Icon(Icons.access_time),
                        trailing: IconButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            var searchList =
                                prefs.getStringList('recentsearchlist') ?? [];
                            searchList.removeWhere(
                              (item) => item == snapshotData[index],
                            );
                            prefs.setStringList('recentsearchlist', searchList);
                            // update provider list
                            searchPvr.updateRecentSearchList(
                              recentSearch: searchList,
                            );
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                        ),
                        title: displayText(
                            recentCtr.recentSearchList[index].toString()),
                      );
                    },
                  );
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          } catch (e) {
            rethrow;
          }
        },
      ),
    );
  }
}

getRecentSearch({required BuildContext context}) async {
  final searchPvr = Provider.of<SearchController>(context, listen: false);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  // get the list, if not found, return empty list.
  var recentSearchList = prefs.getStringList('recentsearchlist') ?? [];
  searchPvr.updateRecentSearchList(recentSearch: recentSearchList);

  return recentSearchList;
}
