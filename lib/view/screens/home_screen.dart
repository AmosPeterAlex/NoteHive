import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:to_do_hive/model/note_model.dart';
import 'package:to_do_hive/view/screens/search_screen.dart';

import '../../controller/note_controller.dart';
import '../utils/my_colors.dart';
import '../utils/my_text_styles.dart';

import '../widgets/notes_card.dart';
import '../widgets/privacy_policy.dart';
import '../widgets/support_page.dart';
import '../widgets/terms-and_conditions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  Color selectedColor = Colors.grey;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<NoteCardController>().loadEvents();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var providerWatch = context.watch<NoteCardController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        centerTitle: true,
        title: Text(
          'NOTEHIVE',
          style: mainTextDark,
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                  ),
                );
              },
              icon: Icon(Icons.search)),
        ],
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.purple, Colors.red])),
          child: Column(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text(
                    'NOTEHIVE',
                    style: mainTextLight,
                  ),
                ),
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: primaryColorLight,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Terms and Conditions', style: subTextLight),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TermsAndConditionScreen(),
                      ));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.mail_outline_outlined,
                      color: primaryColorLight,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Support', style: subTextLight),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SupportScreen(),
                      ));
                },
              ),
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      Icons.privacy_tip_outlined,
                      color: primaryColorLight,
                      size: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('Privacy Policy', style: subTextLight),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PrivacyPolicyScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Consumer<NoteCardController>(
        builder: (context, value, child) {
          return isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: primaryColorDark,
                  ),
                )
              : value.notes.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create a New Note',
                            style: TextStyle(fontSize: 22),
                          ),
                          // CircularProgressIndicator()
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: value.notes.length,
                            itemBuilder: (context, index) {
                              final dateFormatter = DateFormat('dd-MM-yyyy');
                              final note = value.notes[index];
                              final date =
                                  dateFormatter.format(note.date.toLocal());
                              return NoteCard(
                                onEditPressed: () {
                                  value.existingNoteIndex = index;
                                  _addOrEditNote(context, existingNote: note);
                                },
                                onDeletePressed: () async {
                                  await value.deleteEvent(index);
                                  value.loadEvents();
                                },
                                category: note.category,
                                title: note.title,
                                description: note.description,
                                date: date,
                              );
                            },
                          ),
                        ),
                      ],
                    );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColorLight,
        onPressed: () {
          providerWatch.existingNoteIndex = -1;
          _addOrEditNote(context);
        },
        child: Icon(
          Icons.add,
          color: primaryColorDark,
          size: 40,
        ),
      ),
    );
  }

  void _addOrEditNote(BuildContext ctx, {ModelNote? existingNote}) async {
    var providerRead = context.read<NoteCardController>();
    final isEditing = existingNote != null;
    final newNote = isEditing
        ? ModelNote.copy(existingNote)
        : ModelNote(
            category: '',
            title: '',
            description: '',
            date: DateTime.now(),
          );

    _categoryController.text = newNote.category;
    _titleController.text = newNote.title;
    _descriptionController.text = newNote.description;
    final dateFormatter = DateFormat('dd-MM-yyyy');
    _dateController.text =
        isEditing ? dateFormatter.format(newNote.date.toLocal()) : '';

    await showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              backgroundColor: bgColor,
              body: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      AppBar(
                        backgroundColor: bgColor,
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: primaryColorDark,
                          ),
                        ),
                        centerTitle: true,
                        title: Text(isEditing ? 'Edit Note' : 'Add Note',
                            style: mainTextDark),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Category',
                            labelStyle: subTextDark),
                        controller: _categoryController,
                        onChanged: (value) {
                          newNote.category = value;
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Title',
                            labelStyle: subTextDark),
                        controller: _titleController,
                        onChanged: (value) {
                          newNote.title = value;
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextField(
                        maxLines: 5,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Description',
                            labelStyle: subTextDark),
                        controller: _descriptionController,
                        onChanged: (value) {
                          newNote.description = value;
                        },
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: newNote.date,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (selectedDate != null) {
                            setState(
                              () {
                                newNote.date = selectedDate.toUtc();
                                _dateController.text = dateFormatter
                                    .format(newNote.date.toLocal());
                              },
                            );
                          }
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Date (dd-MM-yyyy)',
                                labelStyle: subTextDark),
                            controller: _dateController,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.grey),
                            ),
                            onPressed: () async {
                              if (_categoryController.text.isNotEmpty &&
                                  _titleController.text.isNotEmpty &&
                                  _descriptionController.text.isNotEmpty) {
                                newNote.category = _categoryController.text;
                                newNote.title = _titleController.text;
                                newNote.description =
                                    _descriptionController.text;
                                if (isEditing) {
                                  await providerRead.updateEvent(
                                      providerRead.existingNoteIndex, newNote);
                                } else {
                                  await providerRead.addEvent(newNote);
                                }
                                providerRead.loadEvents();
                                Navigator.of(context).pop();
                              } else {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 2,
                                          color: Colors.grey,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    backgroundColor: primaryColorLight,
                                    content: Center(
                                      child: Text(
                                        "Please add full details ❗",
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              isEditing ? 'Save' : 'Add',
                              style: subTextDark,
                            ),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.grey)),
                            onPressed: () async {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Cancel',
                              style: subTextDark,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
