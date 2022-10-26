import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:undo/undo.dart';

import '../jeu_view.dart';

class BouleBillardEmpoche extends StatefulWidget {
  final Color color;
  final Color textColor;
  final int scoreBalle;
  final Equipe equipeActive;
  final Equipe equipe1;
  final Equipe equipe2;
  final SimpleStack stack;
  const BouleBillardEmpoche(
      {super.key,
      required this.color,
      required this.scoreBalle,
      required this.equipeActive,
      required this.equipe1,
      required this.equipe2,
      required this.stack,
      required this.textColor});

  @override
  State<BouleBillardEmpoche> createState() => _BouleBillardEmpocheState();
}

class _BouleBillardEmpocheState extends State<BouleBillardEmpoche> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: widget.color,
              content: Text(
                "Attention il faut remettre la boule",
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.poppins(color: widget.textColor, fontSize: 22),
              )));
          setState(() {
            widget.equipeActive.score += widget.scoreBalle;
            widget.stack.modify([widget.equipe1.score, widget.equipe2.score]);
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.color,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(13),
        ),
        child: Container(
          height: 75,
        ),
      ),
    );
  }
}
