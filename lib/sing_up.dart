import 'package:flutter/material.dart';

import 'users_repository.dart';
import 'user.dart';
import 'package:email_validator/email_validator.dart';

class SignUpScreen extends StatelessWidget {

  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordAgainController = TextEditingController();

  final _usersRepository = UsersRepository();
  // var email = "tony@starkindustries.com";
  // bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
        body: Container(
           decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/one-punch-man-saitama-manga-wallpaper-preview.jpg'),
                  fit: BoxFit.fitHeight,
                ),
              ),

          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
              TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_box, color: Colors.purple),
                labelText: 'Username', fillColor: Colors.white54,
                filled: true,
                labelStyle: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 25),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                        color: Colors.deepPurple, width: 2.0
                  ),
                  ),
              ),
                  textInputAction: TextInputAction.next,
                validator: (value) {
                      if (value!.isEmpty) return 'Username';
                      if (!value.contains('^(?=.{3,20}\$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])\$')) return 'Enter a valid Username';
                      }
                        ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.mail, color: Colors.purple),
                    labelText: 'E-mail', fillColor: Colors.white54,
                    filled: true,
                    labelStyle: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 25),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: BorderSide(
                          color: Colors.deepPurple, width: 2.0
                      ),
                    ),
                    ),
                    textInputAction: TextInputAction.next,
                //   validator: (value) {
                //         if (value!.isEmpty) return 'E-mail';
                //         if (emailValid) return 'Enter a valid  E-mail';
                //         }
                    validator: (email) =>
                email != null && !EmailValidator.validate(email)
                ? 'Enter a valid email' //form is not valid
                : null, // form is valid
                ),

                TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.purple),
                      labelText: 'Password', fillColor: Colors.white54,
                      filled: true,
                      labelStyle: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 25),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                            color: Colors.deepPurple
                        ),
                      ),
                      ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value!.isEmpty) return 'Password';
                      if (value.length < 7) {
                        return 'Enter min. 7 characters';
                      } else {
                        return null; // form is valid
                        }
                      }
                     ),
              TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock, color: Colors.purple),
                labelText: 'Conform password', fillColor: Colors.white54,
                filled: true,
                labelStyle: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 25),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                      color: Colors.deepPurple
                  ),
                ),
                ),
              textInputAction: TextInputAction.done,
            ),
                ElevatedButton(
                  onPressed: () async {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final passwordAgain = _passwordAgainController.text;
                    if (password == passwordAgain) {
                      await _usersRepository.signUp(User(email, password));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Passwords are not the same'),
                        ),
                      );
                    }
                  },
                  child: const Text('Sign Up'),
                ),
              ],
            )
            ),
        ),
    );
        }
}
// extension EmailValidator on String {
//   bool isValidEmail() {
//     return RegExp(
//         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
//         .hasMatch(this);
//   }
// }