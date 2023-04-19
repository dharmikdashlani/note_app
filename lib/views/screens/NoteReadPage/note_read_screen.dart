import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/firestore_db_helper.dart';
import '../NoteEditorPage/notes_editor_screen.dart';

class NoteReadScreen extends StatefulWidget {
  NoteReadScreen(this.doc, {Key? key}) : super(key: key);

  QueryDocumentSnapshot doc;

  @override
  State<NoteReadScreen> createState() => _NoteReadScreenState();
}

class _NoteReadScreenState extends State<NoteReadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.amberAccent,
            )),
        title: Text("Read Notes"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () async {
              await FirestoreDBHelper.firestoreDBHelper
                  .deleteNotes(id: widget.doc.id);
              Navigator.pop(context);
            },
            child: Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title : ${widget.doc['title']}",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Text(
                  "Description : ${widget.doc['description']}",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
