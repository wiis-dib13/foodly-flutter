import 'package:flutter/material.dart';

class Commentaire {
  final String nom;
  final String texte;
  final double evaluation;
  final DateTime date;

  Commentaire({
    required this.nom,
    required this.texte,
    required this.evaluation,
    required this.date,
  });
}

class CommentairePage extends StatefulWidget {
  const CommentairePage({super.key});

  @override
  _CommentairePageState createState() => _CommentairePageState();
}

class _CommentairePageState extends State<CommentairePage> {
  final List<Commentaire> commentaires = [
    Commentaire(nom: "Alice", texte: "Délicieux plat de pâtes.", evaluation: 5, date: DateTime.now()),
    Commentaire(nom: "Bob", texte: "Très bon burger maison.", evaluation: 4, date: DateTime.now().subtract(const Duration(days: 1))),
    Commentaire(nom: "Charlie", texte: "Pas mal, manque un peu d’épices.", evaluation: 3, date: DateTime.now().subtract(const Duration(days: 2))),
  ];

  final _formKey = GlobalKey<FormState>();
  String nom = '';
  String texte = '';
  double evaluation = 5;

  String getEvaluationMessage(double evaluation) {
    if (evaluation == 5.0) return "Succulent";
    if (evaluation == 4.0) return "Savoureux";
    if (evaluation == 3.0) return "Bon";
    if (evaluation == 2.0) return "Correct";
    return "Peut mieux faire";
  }

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  void _addCommentaire(String commentText) {
    setState(() {
      commentaires.insert(
        0,
        Commentaire(
          nom: "Nouvel utilisateur", // Nom générique
          texte: commentText,
          evaluation: evaluation,
          date: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1), // Fond crème
      appBar: AppBar(
        title: const Text("Avis sur les plats 🍲"),
        backgroundColor: const Color(0xFFFF7043),
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: ListView.builder(
        itemCount: commentaires.length,
        itemBuilder: (context, index) {
          final c = commentaires[index];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: const Color(0xFFD84315),
                child: Text(c.nom[0], style: const TextStyle(color: Colors.white)),
              ),
              title: Text(c.nom, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(c.texte, style: const TextStyle(color: Colors.black87)),
                  const SizedBox(height: 4),
                  Text(formatDate(c.date), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(5, (i) {
                      return Icon(
                        i < c.evaluation ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: 20,
                      );
                    }),
                  ),
                ],
              ),
              trailing: Text(getEvaluationMessage(c.evaluation), style: const TextStyle(color: Colors.deepOrange)),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Évaluation par étoiles
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < evaluation ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      evaluation = index + 1.0;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        texte = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: "Écrivez un commentaire...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    maxLines: 1,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (texte.isNotEmpty) {
                      _addCommentaire(texte); // Ajouter le commentaire
                      setState(() {
                        texte = ''; // Réinitialiser la zone de texte après soumission
                      });
                    }
                  },
                  icon: const Icon(Icons.send),
                  color: Colors.deepOrange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
