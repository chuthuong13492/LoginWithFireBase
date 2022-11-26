import 'package:app_todo/provider/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:app_todo/bloc/todo_bloc.dart';
// import 'package:app_todo/todo/todo_list_container.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Api List'),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logout();
              },
              style: TextButton.styleFrom(primary: Colors.white),
              child: Text('Logout'),
            ),
          ],
        ),
        // body: Container(
        //   alignment: Alignment.center,
        //   color: Colors.teal.shade400,
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         'Profile',
        //         style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //             fontSize: 24,
        //             color: Colors.white),
        //       ),
        //       SizedBox(
        //         height: 32,
        //       ),
        // CircleAvatar(
        //   radius: 40,
        //   backgroundImage: NetworkImage(user.photoURL!),
        // ),
        //       SizedBox(
        //         height: 8,
        //       ),
        //       Text(
        //         'Name: ' + user.displayName!,
        //         style: TextStyle(color: Colors.white, fontSize: 16),
        //       ),
        //       SizedBox(
        //         height: 8,
        //       ),
        //       Text(
        //         'Email: ' + user.email!,
        //         style: TextStyle(color: Colors.white, fontSize: 16),
        //       )
        //     ],
        //   ),
        // ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(user.photoURL),
                      ),
                      // SizedBox(
                      //   width: 15,
                      // ),
                      Expanded(
                        child: Container(
                          height: 50,
                          child: Column(
                            children: [
                              Text(
                                user.displayName,
                                // 'Test',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                user.email,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
                // Text(
                //   user.displayName! + '\n',
                //   style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 16,
                //       fontWeight: FontWeight.bold),
                // ),

                // Expanded(
                //   child: Container(
                //     color: Colors.blue,
                //   ),
                // ),
                // Column(),
              ],
            ),
          ),
        ),
        // body: Provider<TodoBloc>.value(
        //   value: TodoBloc(),
        //   child: TodoListContainer(),
        // ),
      ),
    );
  }
}
