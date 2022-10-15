import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'create_team.dart';

class JeuView extends StatefulWidget {
  const JeuView({super.key});

  @override
  State<JeuView> createState() => _JeuViewState();
}

class _JeuViewState extends State<JeuView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Snooker Score", style: GoogleFonts.poppins(fontSize: 18)),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF53af57)),
              child: Center(
                  child: Text(
                "🎱 Snooker Score 🎱",
                style: GoogleFonts.poppins(fontSize: 18),
              )),
            ),
            ListTile(
                title: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Attention"),
                          content: const Text(
                              "Une partie est en cours, êtes vous sûr de vouloir en démarer une nouvelle ?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateTeam()));
                                },
                                child: const Text("OUI")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("NON")),
                          ],
                        ));
              },
              child: const Text("Nouvelle partie"),
            ))
          ],
        ),
      ),
    ));
  }
}
