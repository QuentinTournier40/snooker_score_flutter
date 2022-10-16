import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snooker_score/jeu_view.dart';

import 'delayed_animation.dart';

enum EQUIPES { equipe1, equipe2 }

class CreateTeam extends StatefulWidget {
  const CreateTeam({super.key});

  @override
  State<CreateTeam> createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  final TextEditingController _controllerEquipe1 = TextEditingController();
  final TextEditingController _controllerEquipe2 = TextEditingController();

  EQUIPES? _equipe = EQUIPES.equipe1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: 600,
            margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 15),
            child: Column(
              children: [
                DelayedAnimation(
                  delay: 600,
                  offsetFinal: -5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Création des équipes",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: const Color(0xFF53af57), fontSize: 26),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  height: 200,
                  child: DelayedAnimation(
                    delay: 600,
                    offsetFinal: -1,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "Équipe 1",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 22),
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: TextField(
                                  controller: _controllerEquipe1,
                                  decoration: const InputDecoration(
                                    hintText: "Nom équipe n°1",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 30,
                            height: 100,
                            child: VerticalDivider(
                              color: Colors.black,
                              thickness: 2,
                              width: 10,
                            ),
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Text(
                                  "Équipe 2",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 22),
                                ),
                              ),
                              SizedBox(
                                  width: 150,
                                  child: TextField(
                                    controller: _controllerEquipe2,
                                    decoration: const InputDecoration(
                                      hintText: "Nom équipe n°2",
                                    ),
                                  ))
                            ],
                          ),
                        ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: DelayedAnimation(
                    offsetFinal: -1,
                    delay: 900,
                    child: SizedBox(
                      width: 300,
                      child: Text(
                        "Quelle est l'équipe qui commence la partie ?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: DelayedAnimation(
                    delay: 1200,
                    offsetFinal: -1,
                    child: ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 160,
                          child: RadioListTile(
                            title: Text(
                              "Équipe 1",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 18),
                            ),
                            value: EQUIPES.equipe1,
                            groupValue: _equipe,
                            onChanged: (equipe) {
                              setState(() {
                                _equipe = equipe;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 160,
                          child: RadioListTile(
                            title: Text(
                              "Équipe 2",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 18),
                            ),
                            value: EQUIPES.equipe2,
                            groupValue: _equipe,
                            onChanged: (equipe) {
                              setState(() {
                                _equipe = equipe;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.all(25),
                    width: double.infinity,
                    child: DelayedAnimation(
                        offsetFinal: -1,
                        delay: 1500,
                        child: ElevatedButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).clearSnackBars();
                              if (_controllerEquipe1.text.isEmpty ||
                                  _controllerEquipe2.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        backgroundColor:
                                            const Color(0xFFC23737),
                                        content: Text(
                                          "Veuillez saisir le nom des équipes.",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 22),
                                        )));
                              } else {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => JeuView(
                                            nomEquipe1: _controllerEquipe1.text,
                                            nomEquipe2: _controllerEquipe2.text,
                                            equipeJouantEnPremier: _equipe)));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF53af57),
                              shape: const StadiumBorder(),
                              padding: const EdgeInsets.all(13),
                            ),
                            child: Text(
                              "Lancer la partie !",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: Colors.black, fontSize: 22),
                            ))))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
