import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notekeeper_app/helpers/firebase_auth_helper.dart';
import 'package:notekeeper_app/helpers/firestore_db_helper.dart';

import '../NoteReadPage/note_read_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController noteTitle = TextEditingController();
  TextEditingController noteDescription = TextEditingController();

  String? title;
  String? description;

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text(
          "Your Notes",
          style: TextStyle(color: Colors.amber),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirestoreDBHelper.db.collection("notes").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>> data =
                snapshot.data as QuerySnapshot<Map<String, dynamic>>;

            List<QueryDocumentSnapshot<Map<String, dynamic>>> allDocs =
                data.docs;
            return GridView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(10),
              itemCount: allDocs.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, 'note_read_page',arguments: allDocs[i]);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NoteReadScreen(allDocs[i]),
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.amber.shade100,
                    ),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${allDocs[i].data()['title']}",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Text(
                            "${date.day}-${date.month}-${date.year}",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "${allDocs[i].data()['description']}",
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amberAccent.shade200,
        onPressed: () {
          Navigator.pushNamed(context, 'note_editor_page');
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
