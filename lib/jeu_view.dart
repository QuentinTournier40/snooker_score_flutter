import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snooker_score/delayed_animation.dart';
import 'package:undo/undo.dart';

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
      {required this.equipeJouantEnPremier,
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

    return SafeArea(
        child: DelayedAnimation(
            delay: 500,
            offsetFinal: -1,
            child: Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    height: 650,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 120,
                              child: Text(
                                widget.nomEquipe1,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: Colors.black, fontSize: 22),
                              )),
                          SizedBox(
                            width: 50,
                            child: Text(
                              "VS",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ),
                          SizedBox(
                              width: 120,
                              child: Text(widget.nomEquipe2,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 22)))
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: (equipeActive == equipe1)
                                    ? Colors.lightGreenAccent
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50))),
                            width: 120,
                            child: Text(equipe1.score.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: Colors.black, fontSize: 50)),
                          ),
                          const SizedBox(
                            width: 50,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: (equipeActive == equipe2)
                                    ? Colors.lightGreenAccent
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(50))),
                            width: 120,
                            child: Text(equipe2.score.toString(),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: Colors.black, fontSize: 50)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        height: 400,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        equipeActive.score += 1;
                                        _simpleStackController.modify(
                                            [equipe1.score, equipe2.score]);
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
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.amber,
                                              content: Text(
                                                "Attention il faut remettre la boule",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 22),
                                              )));
                                      setState(() {
                                        equipeActive.score += 2;
                                        _simpleStackController.modify(
                                            [equipe1.score, equipe2.score]);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber,
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(13),
                                    ),
                                    child: Container(
                                      height: 75,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                "Attention il faut remettre la boule",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 22),
                                              )));
                                      setState(() {
                                        equipeActive.score += 3;
                                        _simpleStackController.modify(
                                            [equipe1.score, equipe2.score]);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(13),
                                    ),
                                    child: Container(
                                      height: 75,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.brown,
                                              content: Text(
                                                "Attention il faut remettre la boule",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 22),
                                              )));
                                      setState(() {
                                        equipeActive.score += 4;
                                        _simpleStackController.modify(
                                            [equipe1.score, equipe2.score]);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.brown,
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(13),
                                    ),
                                    child: Container(
                                      height: 75,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.indigo,
                                              content: Text(
                                                "Attention il faut remettre la boule",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 22),
                                              )));
                                      setState(() {
                                        equipeActive.score += 5;
                                        _simpleStackController.modify(
                                            [equipe1.score, equipe2.score]);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.indigo,
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(13),
                                    ),
                                    child: Container(
                                      height: 75,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor:
                                                  Colors.pinkAccent,
                                              content: Text(
                                                "Attention il faut remettre la boule",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 22),
                                              )));
                                      setState(() {
                                        equipeActive.score += 6;
                                        _simpleStackController.modify(
                                            [equipe1.score, equipe2.score]);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.pinkAccent,
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(13),
                                    ),
                                    child: Container(
                                      height: 75,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.black,
                                              content: Text(
                                                "Attention il faut remettre la boule",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 22),
                                              )));
                                      setState(() {
                                        equipeActive.score += 7;
                                        _simpleStackController.modify(
                                            [equipe1.score, equipe2.score]);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(13),
                                    ),
                                    child: Container(
                                      height: 75,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .clearSnackBars();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: Colors.brown,
                                                content: Text(
                                                  "Attention il faut remettre la boule si c'est une couleur",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                )));
                                        setState(() {
                                          equipeInactive.score += 4;
                                          if (equipeActive == equipe1) {
                                            equipeActive = equipe2;
                                            equipeInactive = equipe1;
                                          } else {
                                            equipeActive = equipe1;
                                            equipeInactive = equipe2;
                                          }
                                          _simpleStackController.modify(
                                              [equipe1.score, equipe2.score]);
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(13),
                                      ),
                                      child: Text(
                                        "-4",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: 22),
                                      )),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .clearSnackBars();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor: Colors.indigo,
                                                content: Text(
                                                  "Attention il faut remettre la boule",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 22),
                                                )));
                                        setState(() {
                                          equipeInactive.score += 5;
                                          if (equipeActive == equipe1) {
                                            equipeActive = equipe2;
                                            equipeInactive = equipe1;
                                          } else {
                                            equipeActive = equipe1;
                                            equipeInactive = equipe2;
                                          }
                                          _simpleStackController.modify(
                                              [equipe1.score, equipe2.score]);
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.indigo,
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(13),
                                      ),
                                      child: Text(
                                        "-5",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: Colors.white, fontSize: 22),
                                      )),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(16),
                                  child: ElevatedButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context)
                                            .clearSnackBars();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                backgroundColor:
                                                    Colors.pinkAccent,
                                                content: Text(
                                                  "Attention il faut remettre la boule",
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 22),
                                                )));
                                        setState(() {
                                          equipeInactive.score += 6;
                                          if (equipeActive == equipe1) {
                                            equipeActive = equipe2;
                                            equipeInactive = equipe1;
                                          } else {
                                            equipeActive = equipe1;
                                            equipeInactive = equipe2;
                                          }
                                          _simpleStackController.modify(
                                              [equipe1.score, equipe2.score]);
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.pinkAccent,
                                        shape: const CircleBorder(),
                                        padding: const EdgeInsets.all(13),
                                      ),
                                      child: Text(
                                        "-6",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: Colors.black, fontSize: 22),
                                      )),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .clearSnackBars();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              backgroundColor: Colors.black,
                                              content: Text(
                                                "Attention il faut remettre la boule",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 22),
                                              )));

                                      setState(() {
                                        equipeInactive.score += 7;
                                        if (equipeActive == equipe1) {
                                          equipeActive = equipe2;
                                          equipeInactive = equipe1;
                                        } else {
                                          equipeActive = equipe1;
                                          equipeInactive = equipe2;
                                        }
                                        _simpleStackController.modify(
                                            [equipe1.score, equipe2.score]);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: const CircleBorder(),
                                      padding: const EdgeInsets.all(13),
                                    ),
                                    child: Text("-7",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: Colors.white, fontSize: 22)))
                              ],
                            ),
                            const SizedBox(
                              height: 35,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
                                const SizedBox(
                                  width: 35,
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
                                const SizedBox(
                                  width: 35,
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text(
                                                "Attention",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.red,
                                                    fontSize: 22),
                                              ),
                                              content: Text(
                                                "Une partie est en cours, êtes vous sûr de vouloir en démarer une nouvelle ?",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .clearSnackBars();
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const CreateTeam()));
                                                    },
                                                    child: Text(
                                                      "OUI",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: Colors.red,
                                                              fontSize: 20),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      "NON",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.green,
                                                              fontSize: 20),
                                                    )),
                                              ],
                                            ));
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
            )));
  }
}
