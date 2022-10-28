import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../create_team.dart';

class PopupRestart extends StatelessWidget {
  const PopupRestart({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Attention",
        style: GoogleFonts.poppins(color: Colors.red, fontSize: 22),
      ),
      content: Text(
        "Une partie est en cours, êtes vous sûr de vouloir en démarer une nouvelle ?",
        style: GoogleFonts.poppins(color: Colors.black, fontSize: 18),
      ),
      actions: [
        TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).clearSnackBars();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateTeam()));
            },
            child: Text(
              "OUI",
              style: GoogleFonts.poppins(color: Colors.red, fontSize: 20),
            )),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "NON",
              style: GoogleFonts.poppins(color: Colors.green, fontSize: 20),
            )),
      ],
    );
  }
}
