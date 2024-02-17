import 'package:flutter/material.dart';

import '../utils/my_colors.dart';
import '../utils/my_text_styles.dart';
import 'notes_card_full_view.dart';

class NoteCard extends StatefulWidget {
  const NoteCard(
      {super.key,
      this.onEditPressed,
      this.onDeletePressed,
      required this.category,
      required this.title,
      required this.description,
      required this.date});

  final void Function()? onEditPressed;
  final void Function()? onDeletePressed;
  final String category;
  final String title;
  final String description;
  final String date;

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return NoteCardFullView(
                  category: widget.category,
                  title: widget.title,
                  description: widget.description,
                  date: widget.date,
                );
              },
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: primaryColorLight,
              border: Border(
                left: BorderSide(
                  color: primaryColorDark,
                  width: 7,
                ),
              ),
              borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient:
                            LinearGradient(colors: [Colors.purple, Colors.red]),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        widget.category,
                        style: subTextLight,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: widget.onEditPressed,
                        icon: Icon(
                          Icons.edit,
                          color: primaryColorDark,
                        ),
                      ),
                      IconButton(
                        onPressed: widget.onDeletePressed,
                        icon: Icon(
                          Icons.delete,
                          color: primaryColorDark,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.title,
                style: mainTextDark,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  widget.description,
                  textAlign: TextAlign.justify,
                  maxLines: 2,
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
                    widget.date,
                    style: subTextDark,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
