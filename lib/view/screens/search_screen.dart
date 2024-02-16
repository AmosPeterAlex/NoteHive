import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

import '../../controller/note_controller.dart';
import '../../controller/search_controller.dart';
import '../utils/my_colors.dart';
import '../utils/my_text_styles.dart';
import '../widgets/news_card_full_view.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var noteCardController = context.read<NoteCardController>();
    var searchScreenController = context.read<SearchScreenController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        leading: Icon(
          Icons.arrow_back_ios,
          color: bgColor,
        ),
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(top: 50, left: 40, right: 30),
          child: TextField(
            autofocus: true,
            controller: searchController,
            onChanged: (value) {
              if (value.isEmpty) {
                setState(() {});
              }
              noteCardController.filterNotes(value);
              setState(() {});
            },
            decoration: InputDecoration(
              prefixIcon: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: primaryColorDark,
                  )),
              contentPadding: EdgeInsets.all(10),
              hintText: "Search for Notes",
              hintStyle: subTextDark,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<NoteCardController>(
        builder: (context, noteController, _) {
          if (searchController.text.isEmpty) {
            return FutureBuilder<List<String>>(
              future: searchScreenController.getRecentSearches(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                      child: Lottie.asset('assets/animation/empty.json'));
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text("Recent Searches", style: mainTextDark),
                        SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final recentSearch = snapshot.data![index];
                              return Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    searchController.text = recentSearch;
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(recentSearch, style: subTextDark),
                                      IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: primaryColorDark,
                                        ),
                                        onPressed: () async {
                                          await searchScreenController
                                              .removeRecentSearch(recentSearch);
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            );
          } else {
            final filteredNotes = noteController.notes
                .where((note) => note.title
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
                .toList();
            if (filteredNotes.isEmpty) {
              return Center(
                child: Lottie.asset('assets/animation/empty.json'),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                      itemCount: filteredNotes.length,
                      itemBuilder: (context, index) {
                        final note = filteredNotes[index];
                        return InkWell(
                          onTap: () async {
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NoteCardFullView(
                                  category: note.category,
                                  title: note.title,
                                  description: note.description,
                                  date: DateFormat('dd-MM-yyyy')
                                      .format(note.date),
                                )));
                            searchScreenController
                                .addRecentSearch(searchController.text);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: primaryColorLight,
                                border: Border(
                                    left: BorderSide(
                                      color: primaryColorDark,
                                      width: 7,
                                    )),
                                borderRadius: BorderRadius.circular(20)),
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Colors.purple,
                                              Colors.red
                                            ]),
                                            borderRadius:
                                            BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            note.category,
                                            style: subTextLight,
                                          ),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  note.title,
                                  style: mainTextDark,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width:
                                  MediaQuery.of(context).size.width * 0.9,
                                  child: Text(
                                    note.description,
                                    textAlign: TextAlign.justify,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: subTextDark,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      DateFormat('dd-MM-yyyy')
                                          .format(note.date),
                                      style: subTextDark,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}