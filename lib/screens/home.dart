import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noteapp/screens/taking_notes.dart';
import '../utilities/notes-list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isListMode = true;
  void updateDisplayMode() => setState(() {
        isListMode = !isListMode;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 80,
                  left: 0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 89,
                  left: 20,
                  child: Text(
                    "Keep Note",
                    style: GoogleFonts.roboto(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                Positioned(
                  top: 80,
                  right: 20,
                  child: IconButton(
                    onPressed: () {
                      updateDisplayMode();
                    },
                    icon: Icon(
                      isListMode ? Icons.list : Icons.grid_view_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: NotesList(
            isListMode: isListMode,
            updateDisplay: updateDisplayMode,
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          "Add Note",
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TakingNote()));
        },
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
