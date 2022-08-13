import 'package:flutter/material.dart';

import 'session_manager.dart';
import 'user.dart';
import 'users_repository.dart';

class LoginScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _usersRepository = UsersRepository();
  final _sessionManager = SessionManager();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Container(
        // padding: EdgeInsets.only(
        //   bottom: MediaQuery.of(context).viewInsets.bottom,
        // ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/cup_of_coffee.png'),
            fit: BoxFit.cover,
          ),
        ),
        child:
            // SingleChildScrollView(
            //child: Column(
            // children: [
            ListView(padding: EdgeInsets.only(top: 10),
                //mainAxisAlignment: MainAxisAlignment.end,
                children: [
              Container(
                margin: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                child: TextField(
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                  controller: _emailController,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.purpleAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: 'e-mail',
                    fillColor: Colors.white54,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.purple),
                    prefixIcon: Icon(Icons.mail, color: Colors.purple),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                child: TextField(
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                  controller: _passwordController,
                  obscureText: true,
                  // textInputAction: TextInputAction.done,
                  // decoration: const InputDecoration(

                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.purpleAccent, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: 'password',
                    fillColor: Colors.white54,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.purple),
                    prefixIcon: Icon(Icons.lock, color: Colors.purple),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(160, 5, 160, 5),
                child: ElevatedButton(
                  onPressed: () async {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final user = User(email, password);
                    if (await _usersRepository.contains(user)) {
                      await _sessionManager.saveSession(user);
                      Navigator.pushReplacementNamed(context, '/home',
                          arguments: email);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Wrong email or password'),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                //child: FittedBox(
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/sign_up');
                  },
                  child: FittedBox(
                    child: Text(
                      //'Firstly here?\n '
                      'Sign up!', textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 45,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 2
                          ..color = Colors.purple[600]!,
                        shadows: [
                          Shadow(
                              color: Colors.white,
                              blurRadius: 3,
                              offset: Offset(0, 0))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
