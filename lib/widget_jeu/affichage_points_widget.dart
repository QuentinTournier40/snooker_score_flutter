import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../jeu_view.dart';

class AffichagePoints extends StatefulWidget {
  final Equipe mainEquipe;
  final Equipe equipe2;
  final Equipe equipeActive;
  final Equipe equipeInactive;
  final double width;
  final onTap;
  const AffichagePoints(
      {super.key,
      required this.mainEquipe,
      required this.equipeActive,
      required this.width,
      this.onTap,
      required this.equipe2,
      required this.equipeInactive});

  @override
  State<AffichagePoints> createState() => _AffichagePointsState();
}

class _AffichagePointsState extends State<AffichagePoints> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(50)),
      onTap: (() {
        widget.onTap(widget.mainEquipe, widget.equipe2, widget.equipeActive,
            widget.equipeInactive);
      }),
      child: Container(
        decoration: BoxDecoration(
            color: (widget.equipeActive == widget.mainEquipe)
                ? Colors.lightGreenAccent
                : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(50))),
        width: widget.width * 0.35,
        child: Text(widget.mainEquipe.score.toString(),
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(color: Colors.black, fontSize: 50)),
      ),
    );
  }
}
