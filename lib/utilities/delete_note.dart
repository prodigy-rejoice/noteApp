import 'package:flutter/material.dart';

class DeleteNote extends StatelessWidget {
  const DeleteNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.pink,
      ),
      child: Column(
        children: [
          Text("Delete note"),
          Text("Are you sure you want to delete this note?"),
          Row(
            children: [
              TextButton(
                onPressed: () {},
                child: Text("CANCEL"),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "DELETE",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
