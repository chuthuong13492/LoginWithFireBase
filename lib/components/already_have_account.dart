// import 'package:flutter/material.dart';

// class AlreadyHaveAccount extends StatelessWidget {
//   final bool login;
//   final Function press;
//   const AlreadyHaveAccount({
//     Key? key,
//     this.login = true,
//     required this.press,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Text(
//           "Don't have an Account ? ",
//           style: TextStyle(color: Colors.white),
//         ),
//         GestureDetector(
//           onTap: () {
//             press;
//           },
//           child: Text(
//             login ? "Sign Up" : "Sign In",
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
