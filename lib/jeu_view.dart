import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snooker_score/delayed_animation.dart';

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DelayedAnimation(
      delay: 500,
      offsetFinal: -1,
      child: Scaffold(
        // appBar: AppBar(
        //   title:
        //       Text("Snooker Score", style: GoogleFonts.poppins(fontSize: 18)),
        // ),
        // drawer: Drawer(
        //   child: ListView(
        //     padding: EdgeInsets.zero,
        //     children: [
        //       DrawerHeader(
        //         decoration: const BoxDecoration(color: Color(0xFF53af57)),
        //         child: Center(
        //             child: Text(
        //           "🎱 Snooker Score 🎱",
        //           style: GoogleFonts.poppins(fontSize: 18),
        //         )),
        //       ),
        //       ListTile(
        //           title: TextButton(
        //         style: TextButton.styleFrom(
        //           textStyle: const TextStyle(fontSize: 20),
        //         ),
        //         onPressed: () {
        //           showDialog(
        //               context: context,
        //               builder: (context) => AlertDialog(
        //                     title: const Text("Attention"),
        //                     content: const Text(
        //                         "Une partie est en cours, êtes vous sûr de vouloir en démarer une nouvelle ?"),
        //                     actions: [
        //                       TextButton(
        //                           onPressed: () {
        //                             Navigator.push(
        //                                 context,
        //                                 MaterialPageRoute(
        //                                     builder: (context) =>
        //                                         const CreateTeam()));
        //                           },
        //                           child: const Text("OUI")),
        //                       TextButton(
        //                           onPressed: () {
        //                             Navigator.pop(context);
        //                           },
        //                           child: const Text("NON")),
        //                     ],
        //                   ));
        //         },
        //         child: const Text("Nouvelle partie"),
        //       ))
        //     ],
        //   ),
        // ),
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              height: 750,
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
                  height: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      child: Text(equipe1.score.toString(),
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 50)),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    SizedBox(
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
                                setState(() {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  equipeActive.score += 2;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.amber,
                                          content: Text(
                                            "Attention il faut remettre la boule",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 16),
                                          )));
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
                                setState(() {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  equipeActive.score += 3;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.green,
                                          content: Text(
                                            "Attention il faut remettre la boule",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 16),
                                          )));
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
                                setState(() {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  equipeActive.score += 4;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.brown,
                                          content: Text(
                                            "Attention il faut remettre la boule",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )));
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
                                setState(() {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  equipeActive.score += 5;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.indigo,
                                          content: Text(
                                            "Attention il faut remettre la boule",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )));
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
                                setState(() {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  equipeActive.score += 6;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.pinkAccent,
                                          content: Text(
                                            "Attention il faut remettre la boule",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 16),
                                          )));
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
                                setState(() {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  equipeActive.score += 7;
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          backgroundColor: Colors.black,
                                          content: Text(
                                            "Attention il faut remettre la boule",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )));
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
                                  setState(() {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    equipeInactive.score += 4;
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
                                  setState(() {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    equipeInactive.score += 5;
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            backgroundColor: Colors.indigo,
                                            content: Text(
                                              "Attention il faut remettre la boule",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            )));
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
                                  setState(() {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    equipeInactive.score += 6;
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            backgroundColor: Colors.pinkAccent,
                                            content: Text(
                                              "Attention il faut remettre la boule",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            )));
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
                          Container(
                            margin: const EdgeInsets.all(16),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    ScaffoldMessenger.of(context)
                                        .clearSnackBars();
                                    equipeInactive.score += 7;
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                            backgroundColor: Colors.black,
                                            content: Text(
                                              "Attention il faut remettre la boule",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            )));
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(13),
                                ),
                                child: Text(
                                  "-7",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 22),
                                )),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                                backgroundColor: const Color(0xFF53af57),
                                shape: const StadiumBorder(),
                                padding: const EdgeInsets.all(13),
                              ),
                              child: Text(
                                "Fin de tour",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                    color: Colors.black, fontSize: 22),
                              ))
                        ],
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    ));
  }
}
