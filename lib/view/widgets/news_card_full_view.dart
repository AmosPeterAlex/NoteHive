import 'package:flutter/material.dart';

import '../utils/my_colors.dart';
import '../utils/my_text_styles.dart';

class NoteCardFullView extends StatefulWidget {
  const NoteCardFullView(
      {super.key,
        required this.category,
        required this.title,
        required this.description,
        this.date});
  final String category;
  final String title;
  final String description;
  final String? date;

  @override
  State<NoteCardFullView> createState() => _NoteCardFullViewState();
}

class _NoteCardFullViewState extends State<NoteCardFullView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorLight,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColorDark,
          ),
        ),
        backgroundColor: primaryColorLight,
        centerTitle: true,
        title: Text(widget.title, style: mainTextDark),
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.purple, Colors.red]),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          widget.category,
                          style: subTextLight,
                        ),
                      )),
                  Text(widget.date.toString(), style: mainTextDark),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 3,
                color: primaryColorDark,
              ),
              SizedBox(
                height: 10,
              ),
              Text(widget.description,
                  textAlign: TextAlign.justify, style: subTextDark),
            ],
          ),
        ),
      ]),
    );
  }
}