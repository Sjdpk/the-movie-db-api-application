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
    final searchPvr = Provider.of<SearchController>(context, listen: false);
    Future.delayed(Duration.zero, () {
      searchPvr.updateSearchList(names);
      searchPvr.namesList = names;
    });

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Consumer<SearchController>(
            builder: (context, searchCtr, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          height: 40,
                          decoration: decoration,
                          child: TextFormField(
                            controller: searchController,
                            cursorColor: Colors.black,
                            onChanged: (value) {
                              searchCtr.updateSearchText(value);
                              List<String> newList = [];

                              for (var i = 0;
                                  i < searchCtr.namesList.length;
                                  i++) {
                                if (searchCtr.namesList[i]
                                    .toLowerCase()
                                    .contains(value.toLowerCase())) {
                                  newList.add(searchCtr.namesList[i]);
                                }
                              }
                              searchCtr.updateSearchList(newList);
                              if (value == "") {
                                searchCtr.updateSearchList(searchCtr.namesList);
                              }

                              // List<String> newUserList = searchPvr.namesList;
                              // for (var i = 0;
                              //     i < searchCtr.namesList.length;
                              //     i++) {
                              //   if (searchCtr.namesList[i]
                              //       .toLowerCase()
                              //       .contains(value.toLowerCase())) {
                              //     searchPvr.updateNameList(searchCtr.namesList);
                              //   }
                              // }
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                splashRadius: 0.1,
                                onPressed: () {
                                  searchController.clear();
                                  searchCtr.updateSearchText("");
                                  searchCtr
                                      .updateSearchList(searchCtr.namesList);
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
                          ),
                        ),
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
                    searchCtr.searchText == ""
                        ? "Popular Movies"
                        : "Popular Movies",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    bottomPadding: 14,
                    topPadding: 14,
                  ),
                  searchCtr.searchList.isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 192,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                          itemCount: searchCtr.searchList.length,
                          itemBuilder: (context, index) {
                            return displaymovieCard(
                              image:
                                  "https://images.unsplash.com/photo-1608186336271-53313eeaf864?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80",
                              moviename: searchCtr.searchList[index],
                            );
                          },
                        )
                      : Center(
                          child: displayText(
                            "No Movie Found 🧐 ",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            topPadding: 30,
                          ),
                        ),
                ],
              );
            },
          )),
    );
  }
}

const names = [
  "Camila	Chapman",
  "Belinda	Cameron",
  "Amelia	Harris",
  "Aldus	Howard",
  "Mike	Ryan",
  "Adelaide	Perry",
  "Derek	Hall",
  "Cherry	Ryan",
  "Derek	Owens",
  "John	Walker",
  "Belinda	Ferguson",
  "Vanessa	Barrett",
  "Julian	Foster",
  "Jasmine	Evans",
  "Sabrina	Hunt",
  "Deanna	Carroll",
  "Hailey	Murray",
  "Maximilian	Crawford",
  "Grace	Wright",
  "Garry	Murphy",
  "Catherine	Ferguson",
  "Amelia	Watson",
  "Alisa	Baker",
  "Maria	Miller",
  "Daisy	Harper",
  "Michelle	West",
  "Caroline	Taylor",
  "Heather	West",
  "Justin	Lloyd",
  "Lydia	Cameron",
  "Daryl	Harris",
  "Tara	Robinson",
  "Haris	Wells",
  "Emily	Scott",
  "Catherine	Wells",
  "Ned	Murphy",
  "Blake	Casey",
  "Chelsea	Mitchell",
  "Stuart	Reed",
  "Ellia	Jones",
  "Florrie	Lloyd",
  "Blake	Barnes",
  "Jack	Cole",
  "Adele	Henderson",
  "Jessica	Rogers",
  "Florrie	Barrett",
  "Ryan	Owens",
  "Briony	Dixon",
  "Alexander	Cole",
  "Jessica	Casey",
  "Ryan	Grant",
  "Emily	Fowler",
  "Edith	Turner",
  "Max	Payne",
  "Melanie	Davis",
  "Lucas	Mitchell",
  "Aldus	Warren",
  "Ashton	Kelley",
  "Frederick	Armstrong",
  "Chester	Smith",
  "Alissa	Riley",
  "Bruce	Rogers",
  "Edgar	Armstrong",
  "Cadie	Cooper",
  "Ryan	Scott",
  "Rebecca	Campbell",
  "Rebecca	Parker",
  "Grace	Bennett",
  "Alen	Cunningham",
  "Lucia	Douglas",
  "Sydney	Allen",
  "Roland	Cole",
  "Eddy	Lloyd",
  "Haris	Murphy",
  "Fiona	Farrell",
  "Honey	Jones",
  "Edward	Watson",
  "Ada	Harris",
  "Jordan	Owens",
  "Carlos	Stevens",
  "Alissa	Howard",
  "Madaline	Smith",
  "Luke	Carroll",
  "Paul	Campbell",
  "Adrian	Murray",
  "Ashton	Brown",
  "Ned	Harris",
  "Michelle	Thomas",
  "Ted	Evans",
  "Adelaide	Hawkins",
  "Sydney	Hall",
  "Arnold	Ross",
  "Clark	Stewart",
  "Carl	Smith",
  "Vivian	Watson",
  "Sam	Wells",
  "Arnold	Stevens",
  "Vivian	Miller",
  "John	Hawkins",
  "Edgar	Payne",
];
