import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:undo/undo.dart';

import '../jeu_view.dart';

class BouleBillardBlouse extends StatefulWidget {
  final Color color;
  final Color textColor;
  final String textSnackBar;
  final int scoreBoule;
  final Equipe equipe1;
  final Equipe equipe2;
  final Equipe equipeInactive;
  final Equipe equipeActive;
  final onChange;
  final SimpleStack stack;
  const BouleBillardBlouse(
      {super.key,
      required this.color,
      required this.scoreBoule,
      required this.equipe1,
      required this.equipe2,
      required this.textColor,
      required this.stack,
      required this.onChange,
      required this.equipeInactive,
      required this.textSnackBar,
      required this.equipeActive});

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
                  widget.textSnackBar,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      color: widget.textColor, fontSize: 22),
                )));
            setState(() {
              widget.equipeInactive.score += widget.scoreBoule;
              widget.stack.modify([widget.equipe1.score, widget.equipe2.score]);
            });
            widget.onChange(widget.equipe1, widget.equipe2, widget.equipeActive,
                widget.equipeInactive);
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
