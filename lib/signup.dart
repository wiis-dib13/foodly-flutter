// import 'package:flutter/material.dart';

// class SignUpPage extends StatefulWidget {
//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   bool _obscurePassword = true;
//   bool _obscureConfirmPassword = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       backgroundColor: Colors.black,
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(Icons.arrow_back, color: Colors.white),
//                 onPressed: () => Navigator.pop(context),
//               ),
//               SizedBox(height: 10),
//               // 🌟 En-tête avec dégradé et motif
//               Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.black, Colors.black87],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                 ),
//                 padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
//                 width: double.infinity,
//                 child: Column(
//                   children: [
//                     Text(
//                       "Sign Up",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       "Please sign up to get started",
//                       style: TextStyle(color: Colors.white70, fontSize: 16),
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 20),

//               // 🏷️ Formulaire avec bordure blanche
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
//                 width: 400,
//                 height: 700,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(24),
//                     topRight: Radius.circular(24),
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(20),
//                 width: 350,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(24),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black12,
//                       blurRadius: 10,
//                       spreadRadius: 2,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildLabel("NAME"),
//                     _buildTextField("John doe", false),
//                     SizedBox(height: 10),
//                     _buildLabel("EMAIL"),
//                     _buildTextField("example@gmail.com", false),
//                     SizedBox(height: 10),
//                     _buildLabel("PASSWORD"),
//                     _buildPasswordField(true),
//                     SizedBox(height: 10),
//                     _buildLabel("RE-TYPE PASSWORD"),
//                     _buildPasswordField(false),
//                     SizedBox(height: 20),

//                     // Bouton de validation
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           padding: EdgeInsets.symmetric(vertical: 15),
//                           backgroundColor: Colors.green,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Text(
//                           "SIGN UP",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Widget pour les labels
//   Widget _buildLabel(String text) {
//     return Text(
//       text,
//       style: TextStyle(
//         color: Colors.black54,
//         fontSize: 14,
//         fontWeight: FontWeight.bold,
//       ),
//     );
//   }

//   // Widget pour les champs de texte
//   Widget _buildTextField(String hint, bool isPassword) {
//     return TextField(
//       decoration: InputDecoration(
//         hintText: hint,
//         filled: true,
//         fillColor: Colors.grey[200],
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }

//   // Widget pour les champs de mot de passe avec visibilité
//   Widget _buildPasswordField(bool isFirstPassword) {
//     return TextField(
//       obscureText: isFirstPassword ? _obscurePassword : _obscureConfirmPassword,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.grey[200],
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         suffixIcon: IconButton(
//           icon: Icon(
//             isFirstPassword
//                 ? (_obscurePassword ? Icons.visibility_off : Icons.visibility)
//                 : (_obscureConfirmPassword
//                     ? Icons.visibility_off
//                     : Icons.visibility),
//           ),
//           onPressed: () {
//             setState(() {
//               if (isFirstPassword) {
//                 _obscurePassword = !_obscurePassword;
//               } else {
//                 _obscureConfirmPassword = !_obscureConfirmPassword;
//               }
//             });
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fond de la page
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Section du haut avec le fond noir et l'icône retour
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Please sign up to get started",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Formulaire blanc
            Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              width: 400,
              height: 700,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("NAME"),
                  _buildTextField("John doe"),
                  SizedBox(height: 10),
                  _buildLabel("EMAIL"),
                  _buildTextField("example@gmail.com"),
                  SizedBox(height: 10),
                  _buildLabel("PASSWORD"),
                  _buildPasswordField(true,"*********"),
                  
                  SizedBox(height: 10),
                  _buildLabel("RE-TYPE PASSWORD"),
                  _buildPasswordField(false,"*********"),
                  SizedBox(height: 20),

                  // Bouton "Sign Up"
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "SIGN UP",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour les labels
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black54,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // Widget pour les champs de texte
  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // Widget pour les champs de mot de passe avec visibilité
  Widget _buildPasswordField(bool isFirstPassword,String hint) {
    return TextField(
      obscureText: isFirstPassword ? _obscurePassword : _obscureConfirmPassword,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isFirstPassword
                ? (_obscurePassword ? Icons.visibility_off : Icons.visibility)
                : (_obscureConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility),
          ),
          onPressed: () {
            setState(() {
              if (isFirstPassword) {
                _obscurePassword = !_obscurePassword;
              } else {
                _obscureConfirmPassword = !_obscureConfirmPassword;
              }
            });
          },
        ),
        hintText: hint,
      ),
      
    );
  }
}
