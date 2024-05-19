import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/screens/taking_notes.dart';

class NotesList extends StatelessWidget {
  NotesList({
    super.key,
    required this.updateDisplay,
    required this.isListMode,
  });

  final bool isListMode;
  final VoidCallback updateDisplay;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide.none,
              ),
              hintText: 'Search note...',
              prefixIcon: const Icon(Icons.search_outlined),
              suffixIcon: IconButton(
                onPressed: () {
                  _controller.text = '';
                },
                icon: const Icon(Icons.highlight_remove_rounded),
              ),
              fillColor: const Color(0xffEFF2F9),
              filled: true,
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                borderSide: BorderSide(color: Colors.black, width: 0.7),
              ),
            ),
          ),
          Expanded(
            child: isListMode ? _buildVerticalList() : _buildGridList(),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Notes").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "No notes to view, click the button below to create a note",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(fontSize: 18, color: Colors.black54),
              ),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  return NoteCard(
                    doc: snapshot.data!.docs[index],
                  );
                });
          }
          return Text(
            "there are no notes to view,",
            style: GoogleFonts.nunito(color: Colors.white),
          );
        });
  }

  Widget _buildGridList() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Notes").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "No notes to view, click the button below to create a note",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(fontSize: 18, color: Colors.black54),
              ),
            );
          }
          if (snapshot.hasData) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  return NoteCard(
                    doc: snapshot.data!.docs[index],
                  );
                });
          }
          return Text(
            "there are no notes to view,",
            style: GoogleFonts.nunito(color: Colors.white),
          );
        });
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, this.doc});
  final QueryDocumentSnapshot? doc;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TakingNote(doc: doc)));
          },
          child: Card(
            color: const Color(0xffEFF2F9),
            elevation: 0,
            child: SizedBox(
              child: Column(
                children: [
                  ListTile(
                    contentPadding: const EdgeInsets.all(8),
                    title: Text(
                      doc?["note_title"],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(doc?["note_content"],
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
            ),
          ),
        ),
        // Positioned(
        //   right: 20,
        //   bottom: 20,
        //   child: CircleAvatar(radius: 5, backgroundColor: Colors.redAccent),
        // ),
      ],
    );
  }
}
