import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:snooker_score/create_team.dart';
import 'package:snooker_score/delayed_animation.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
            child: Container(
          margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: DelayedAnimation(
                  offsetFinal: -1,
                  delay: 1500,
                  child: Text(
                    "Bienvenue sur Snooker Score",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                  )),
            ),
            const DelayedAnimation(
              offsetFinal: -1,
              delay: 1500,
              child: Divider(
                color: Colors.black,
                height: 15,
                thickness: 2,
                indent: 10,
                endIndent: 10,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(25),
              width: double.infinity,
              child: DelayedAnimation(
                  offsetFinal: -1,
                  delay: 2250,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CreateTeam()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF53af57),
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.all(13),
                      ),
                      child: Text(
                        "Nouvelle partie",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 22),
                      ))),
            ),
          ]),
        )),
      ),
    );
  }
}
