import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'home.dart';

class TakingNote extends StatefulWidget {
  const TakingNote({
    super.key,
    this.doc,
  });
  final QueryDocumentSnapshot? doc;
  @override
  State<TakingNote> createState() => _TakingNoteState();
}

class _TakingNoteState extends State<TakingNote> {
  late TextEditingController contentController = TextEditingController();
  late TextEditingController titleController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    super.initState();
    if (widget.doc != null) {
      titleController = TextEditingController(text: widget.doc?["note_title"]);
      contentController =
          TextEditingController(text: widget.doc?["note_content"]);
    } else {
      titleController = TextEditingController();
      contentController = TextEditingController();
    }
  }

  Future<void> deleteNote() async {
    if (widget.doc != null) {
      try {
        _firestore.collection('Notes').doc(widget.doc!.id).delete();
        titleController.text = '';
        contentController.text = '';
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            duration: Duration(milliseconds: 500),
            content: Text("Note deleted successfully")));
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: const Duration(seconds: 1),
          content: Text("Error deleting note: $e"),
        ));
      }
    }
  }

  Future<void> addNote() async {
    final String title = titleController.text.trim();
    final String content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            duration: Duration(seconds: 1),
            content: Text("Title and note cannot be empty")),
      );
      return;
    }
    if (widget.doc == null) {
      try {
        await _firestore.collection('Notes').add({
          'note_title': title,
          'note_content': content,
          'date_edited': Timestamp.now(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              duration: Duration(seconds: 1),
              content: Text("Note saved successfully")),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              duration: Duration(seconds: 1),
              content: Text('Error saving note: $e')),
        );
      }
    } else {
      try {
        await _firestore.collection('Notes').doc(widget.doc!.id).update({
          'note_title': title,
          'note_content': content,
          'date_edited': Timestamp.now(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              duration: Duration(seconds: 1),
              content: Text('Note updated successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              duration: Duration(seconds: 1),
              content: Text('Error updating note: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            },
            icon: const Icon(Icons.arrow_back_outlined, size: 25)),
        title: Text(
          "Notes",
          style: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          const Icon(Icons.share_outlined, size: 25, color: Colors.black),
          const SizedBox(width: 20),
          GestureDetector(
            child:
                const Icon(Icons.delete_outline, size: 25, color: Colors.black),
            onTap: () {
              Alert(
                context: context,
                title: "Delete note",
                desc: "Are you sure you want to delete this note?",
                style: AlertStyle(
                  // constraints: const BoxConstraints(
                  //   minWidth: double.infinity,
                  //   maxWidth: double.infinity,
                  // ),
                  backgroundColor: Colors.black12,
                  alertBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  alertElevation: 0,
                  buttonAreaPadding: EdgeInsets.all(10),
                  isCloseButton: false,
                  alertAlignment: Alignment.bottomLeft,
                  titleStyle:
                      GoogleFonts.roboto(color: Colors.white, fontSize: 15),
                  titleTextAlign: TextAlign.left,
                  descStyle:
                      GoogleFonts.roboto(color: Colors.white, fontSize: 15),
                  descTextAlign: TextAlign.left,
                ),
                buttons: [
                  DialogButton(
                    onPressed: () {},
                    border: Border.fromBorderSide(BorderSide.none),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          child: Text(
                            "CANCEL",
                            style: GoogleFonts.roboto(color: Colors.white),
                          ),
                          onTap: () => Navigator.pop(context),
                        ),
                        GestureDetector(
                          child: Text(
                            "DELETE",
                            style: GoogleFonts.roboto(color: Colors.red),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            deleteNote();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ).show();
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: TextField(
                    controller: titleController,
                    style: const TextStyle(
                        fontSize: 19, fontWeight: FontWeight.w500),
                    decoration: InputDecoration(
                      hintText: 'Title',
                      hintStyle: GoogleFonts.inter(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 10, 10),
                  child: TextField(
                    controller: contentController,
                    decoration: InputDecoration(
                      hintText: 'Take a note...',
                      hintStyle: GoogleFonts.inter(color: Colors.black),
                      border: InputBorder.none,
                    ),
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    autofocus: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        shape: const CircleBorder(),
        onPressed: () async {
          await addNote();
          FocusScope.of(context).unfocus();
        },
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
    );
  }
}
