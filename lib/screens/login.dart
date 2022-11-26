import 'package:app_todo/components/already_have_account.dart';
import 'package:app_todo/main.dart';
import 'package:app_todo/provider/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:app_todo/provider/google_sign_in.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPass = false;
  static Future<User> loginUsingEmailPassword(
      {String email, String password, BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No User found for that email");
      }
    }

    return user;
  }

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.tealAccent,
                  fontSize: 40.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20.0,
                width: 100.0,
                child: Divider(
                  color: Colors.tealAccent,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Container(
                // margin: EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),

                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Colors.teal,
                    ),
                    hintText: "Username",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                // margin: EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                // child: TextField(
                //   controller: _passController,
                //   obscureText: true,
                //   decoration: InputDecoration(
                //     icon: Icon(
                //       Icons.lock,
                //       color: Colors.teal,
                //     ),
                //     hintText: "Password",
                //     suffixIcon: Icon(
                //       _showPass ? Icons.visibility : Icons.visibility_off,
                //       color: Colors.teal,
                //     ),
                //     border: InputBorder.none,
                //   ),
                // ),
                child: Stack(
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    TextField(
                      controller: _passController,
                      obscureText: !_showPass,
                      // decoration: InputDecoration(
                      //   icon: Icon(
                      //     Icons.lock,
                      //     color: Colors.teal,
                      //   ),
                      //   hintText: "Password",
                      // ),
                      decoration: myInputDecoration(),
                    ),
                    GestureDetector(
                      onTap: onToggleShowPass,
                      child: Icon(
                        _showPass ? Icons.visibility : Icons.visibility_off,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: 300,
                child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(29),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 15.0,
                  ),
                  fillColor: Colors.white,
                  onPressed: () async {
                    User user = await loginUsingEmailPassword(
                        email: _emailController.text,
                        password: _passController.text,
                        context: context);
                    print(user);
                    if (user != null) {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.teal),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                icon: FaIcon(
                  FontAwesomeIcons.google,
                  // color: Colors.red,
                ),
                // style: ElevatedButton.styleFrom(
                //   primary: Colors.white,
                //   onPrimary: Colors.white,
                // ),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.googeLogin();
                },
                label: Text('Google Login'),
              ),
              SizedBox(
                height: 10,
              ),
              // AlreadyHaveAccount(
              //   press: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }

  BorderRadius myBorder() {
    return BorderRadius.circular(30);
  }

  Icon myIcon() {
    return Icon(FontAwesomeIcons.google);
  }

  InputDecoration myInputDecoration() {
    return InputDecoration(
      icon: Icon(
        Icons.lock,
        color: Colors.teal,
      ),
      hintText: "Password",
      border: InputBorder.none,
    );
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  // Widget gotoHome(BuildContext context) {
  //   return HomePage();
  // }
}

class LoginScreen extends StatelessWidget {
  Future<FirebaseApp> _initializeFireBase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        // future: _initializeFireBase(),
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            print(snapshot.hasData);
            return HomePage();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Something Went Wrong!'),
            );
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}



// class LoginScreen extends StatefulWidget {
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   Future<FirebaseApp> _initializeFireBase() async {
//     FirebaseApp firebaseApp = await Firebase.initializeApp();
//     return firebaseApp;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder(
//         // future: _initializeFireBase(),
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.hasData) {
//             return LoginPage();
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Something Went Wrong!'),
//             );
//           } else {
//             return MyApp();
//           }
//         },
//       ),
//     );
//   }
// }
