import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snooker_score/delayed_animation.dart';
import 'package:snooker_score/widget_jeu/affichage_points_widget.dart';
import 'package:snooker_score/widget_jeu/boule_billar_blouse_widget.dart';
import 'package:snooker_score/widget_jeu/popup_restart_widget.dart';
import 'package:undo/undo.dart';
import 'package:snooker_score/widget_jeu/boule_billard_empoche_widget.dart';

import 'create_team.dart';

class Equipe {
  String nom;
  int score;

  Equipe({required this.nom, required this.score});
}

class JeuView extends StatefulWidget {
  final String nomEquipe1;
  final String nomEquipe2;
  final EQUIPES? equipeJouantEnPremier;

  const JeuView(
      {super.key,
      required this.equipeJouantEnPremier,
      required this.nomEquipe1,
      required this.nomEquipe2});

  @override
  State<JeuView> createState() => _JeuViewState();
}

class _JeuViewState extends State<JeuView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late SimpleStack _simpleStackController;
  late Equipe equipe1;
  late Equipe equipe2;
  late Equipe equipeActive;
  late Equipe equipeInactive;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    equipe1 = Equipe(nom: widget.nomEquipe1, score: 0);
    equipe2 = Equipe(nom: widget.nomEquipe2, score: 0);

    if (widget.equipeJouantEnPremier == EQUIPES.equipe1) {
      equipeActive = equipe1;
      equipeInactive = equipe2;
    } else {
      equipeActive = equipe2;
      equipeInactive = equipe1;
    }

    _simpleStackController = SimpleStack<List<int>>(
        [equipe1.score, equipe2.score], onUpdate: ((val) {
      if (mounted) {
        setState(() {});
      }
    }));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    equipe1.score = _simpleStackController.state[0];
    equipe2.score = _simpleStackController.state[1];

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return DelayedAnimation(
        delay: 500,
        offsetFinal: -1,
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: height,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: width * 0.45,
                          child: Text(
                            widget.nomEquipe1,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 22),
                          )),
                      SizedBox(
                        width: width * 0.1,
                        child: Text(
                          "VS",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                          width: width * 0.45,
                          child: Text(widget.nomEquipe2,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 22)))
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AffichagePoints(
                        mainEquipe: equipe1,
                        equipeActive: equipeActive,
                        width: width,
                        equipe2: equipe2,
                        equipeInactive: equipeInactive,
                        onTap:
                            (equipe1, equipe2, equipeActive, equipeInactive) {
                          setState(() {
                            this.equipeActive = this.equipe1;
                            this.equipeInactive = this.equipe2;
                          });
                        },
                      ),
                      SizedBox(
                        width: width * 0.2,
                      ),
                      AffichagePoints(
                        mainEquipe: equipe2,
                        equipeActive: equipeActive,
                        width: width,
                        equipe2: equipe1,
                        equipeInactive: equipeInactive,
                        onTap:
                            (equipe1, equipe2, equipeActive, equipeInactive) {
                          setState(() {
                            this.equipeActive = this.equipe2;
                            this.equipeInactive = this.equipe1;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  SizedBox(
                    height: height * 0.70,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(16),
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    equipeActive.score += 1;
                                    _simpleStackController
                                        .modify([equipe1.score, equipe2.score]);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(13),
                                ),
                                child: Container(
                                  height: 75,
                                ),
                              ),
                            ),
                            BouleBillardEmpoche(
                              color: Colors.amber,
                              scoreBalle: 2,
                              equipeActive: equipeActive,
                              equipe1: equipe1,
                              equipe2: equipe2,
                              stack: _simpleStackController,
                              textColor: Colors.black,
                            ),
                            BouleBillardEmpoche(
                              color: Colors.green,
                              scoreBalle: 3,
                              equipeActive: equipeActive,
                              equipe1: equipe1,
                              equipe2: equipe2,
                              stack: _simpleStackController,
                              textColor: Colors.black,
                            ),
                            BouleBillardEmpoche(
                              color: Colors.brown,
                              scoreBalle: 4,
                              equipeActive: equipeActive,
                              equipe1: equipe1,
                              equipe2: equipe2,
                              stack: _simpleStackController,
                              textColor: Colors.black,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            BouleBillardEmpoche(
                              color: Colors.indigo,
                              scoreBalle: 5,
                              equipeActive: equipeActive,
                              equipe1: equipe1,
                              equipe2: equipe2,
                              stack: _simpleStackController,
                              textColor: Colors.white,
                            ),
                            BouleBillardEmpoche(
                              color: Colors.pinkAccent,
                              scoreBalle: 6,
                              equipeActive: equipeActive,
                              equipe1: equipe1,
                              equipe2: equipe2,
                              stack: _simpleStackController,
                              textColor: Colors.black,
                            ),
                            BouleBillardEmpoche(
                              color: Colors.black,
                              scoreBalle: 7,
                              equipeActive: equipeActive,
                              equipe1: equipe1,
                              equipe2: equipe2,
                              stack: _simpleStackController,
                              textColor: Colors.white,
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            BouleBillardBlouse(
                              color: Colors.brown,
                              scoreBoule: 4,
                              equipe1: equipe1,
                              equipe2: equipe2,
                              equipeActive: equipeActive,
                              equipeInactive: equipeInactive,
                              textColor: Colors.white,
                              stack: _simpleStackController,
                              onChange: (equipe1, equipe2, equipeActive,
                                  equipeInactive) {
                                setState(() {
                                  if (this.equipeActive == this.equipe1) {
                                    this.equipeActive = equipe2;
                                    this.equipeInactive = equipe1;
                                  } else {
                                    this.equipeActive = this.equipe1;
                                    this.equipeInactive = this.equipe2;
                                  }
                                });
                              },
                              textSnackBar:
                                  "Attention il faut remettre la boule si c'est une couleur",
                            ),
                            BouleBillardBlouse(
                              color: Colors.indigo,
                              scoreBoule: 5,
                              equipe1: equipe1,
                              equipe2: equipe2,
                              equipeActive: equipeActive,
                              equipeInactive: equipeInactive,
                              textColor: Colors.white,
                              stack: _simpleStackController,
                              onChange: (equipe1, equipe2, equipeActive,
                                  equipeInactive) {
                                setState(() {
                                  if (this.equipeActive == this.equipe1) {
                                    this.equipeActive = equipe2;
                                    this.equipeInactive = equipe1;
                                  } else {
                                    this.equipeActive = this.equipe1;
                                    this.equipeInactive = this.equipe2;
                                  }
                                });
                              },
                              textSnackBar:
                                  "Attention il faut remettre la boule",
                            ),
                            BouleBillardBlouse(
                              color: Colors.pinkAccent,
                              scoreBoule: 6,
                              equipe1: equipe1,
                              equipe2: equipe2,
                              equipeActive: equipeActive,
                              equipeInactive: equipeInactive,
                              textColor: Colors.black,
                              stack: _simpleStackController,
                              onChange: (equipe1, equipe2, equipeActive,
                                  equipeInactive) {
                                setState(() {
                                  if (this.equipeActive == equipe1) {
                                    this.equipeActive = equipe2;
                                    this.equipeInactive = equipe1;
                                  } else {
                                    this.equipeActive = equipe1;
                                    this.equipeInactive = this.equipe2;
                                  }
                                });
                              },
                              textSnackBar:
                                  "Attention il faut remettre la boule",
                            ),
                            BouleBillardBlouse(
                              color: Colors.black,
                              scoreBoule: 7,
                              equipe1: equipe1,
                              equipe2: equipe2,
                              equipeActive: equipeActive,
                              equipeInactive: equipeInactive,
                              textColor: Colors.white,
                              stack: _simpleStackController,
                              onChange: (equipe1, equipe2, equipeActive,
                                  equipeInactive) {
                                setState(() {
                                  if (this.equipeActive == this.equipe1) {
                                    this.equipeActive = equipe2;
                                    this.equipeInactive = equipe1;
                                  } else {
                                    this.equipeActive = this.equipe1;
                                    this.equipeInactive = this.equipe2;
                                  }
                                });
                              },
                              textSnackBar:
                                  "Attention il faut remettre la boule",
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (mounted) {
                                  setState(() {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    _simpleStackController.undo();
                                  });
                                }
                              },
                              icon: const Icon(
                                Icons.undo,
                                size: 35,
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (equipeActive == equipe1) {
                                      equipeActive = equipe2;
                                      equipeInactive = equipe1;
                                    } else {
                                      equipeActive = equipe1;
                                      equipeInactive = equipe2;
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  shape: const StadiumBorder(),
                                  padding: const EdgeInsets.all(13),
                                ),
                                child: Text(
                                  "Fin du tour",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 22),
                                )),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => const PopupRestart());
                              },
                              icon: const Icon(
                                Icons.refresh,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            ),
          ),
        ));
  }
}
