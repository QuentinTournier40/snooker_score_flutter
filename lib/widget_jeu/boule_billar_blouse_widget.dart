import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:undo/undo.dart';

import '../jeu_view.dart';

class BouleBillardBlouse extends StatefulWidget {
  final Color color;
  final Color textColor;
  final int scoreBoule;
  final Equipe equipe1;
  final Equipe equipe2;
  late Equipe equipeActive;
  late Equipe equipeInactive;
  final SimpleStack stack;
  BouleBillardBlouse(
      {super.key,
      required this.color,
      required this.scoreBoule,
      required this.equipe1,
      required this.equipe2,
      required this.equipeActive,
      required this.equipeInactive,
      required this.textColor,
      required this.stack});

  @override
  State<BouleBillardBlouse> createState() => _BouleBillardBlouseState();
}

class _BouleBillardBlouseState extends State<BouleBillardBlouse> {
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
                  "Attention il faut remettre la boule si c'est une couleur",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: widget.textColor, fontSize: 16),
                )));
            setState(() {
              widget.equipeInactive.score += 4;
              if (widget.equipeActive == widget.equipe1) {
                widget.equipeActive = widget.equipe2;
                widget.equipeInactive = widget.equipe1;
              } else {
                widget.equipeActive = widget.equipe1;
                widget.equipeInactive = widget.equipe2;
              }
              widget.stack.modify([widget.equipe1.score, widget.equipe2.score]);
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(13),
          ),
          child: Text(
            "-${widget.scoreBoule}",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(color: widget.textColor, fontSize: 22),
          )),
    );
  }
}
