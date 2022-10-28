import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../jeu_view.dart';

class AffichagePoints extends StatefulWidget {
  final Equipe equipe;
  final Equipe equipeActive;
  final double width;
  const AffichagePoints(
      {super.key,
      required this.equipe,
      required this.equipeActive,
      required this.width});

  @override
  State<AffichagePoints> createState() => _AffichagePointsState();
}

class _AffichagePointsState extends State<AffichagePoints> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: (widget.equipeActive == widget.equipe)
              ? Colors.lightGreenAccent
              : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(50))),
      width: widget.width * 0.35,
      child: Text(widget.equipe.score.toString(),
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 50)),
    );
  }
}
