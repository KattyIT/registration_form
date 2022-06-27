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
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/88a5f6155d56f3aa13345dec31a00836.jpg'),
          fit: BoxFit.contain,
        ),
      ),
      child:Scaffold(
        backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(style: TextStyle(fontSize: 20.0, color: Colors.purple),
                controller: _emailController,

        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purpleAccent, width: 2.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 2.0),
            borderRadius: BorderRadius.circular(20.0),
          ),

                hintText: 'email',
                hintStyle: TextStyle(color: Colors.purpleAccent),
                prefixIcon: Icon(Icons.mail, color: Colors.purpleAccent),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    borderSide: BorderSide(
                        color: Colors.purple
                    ),
    ),
              ),
              ),
                TextField(style: TextStyle(fontSize: 20.0, color: Colors.purple),
                  controller: _passwordController,
                  obscureText: true,
                  // textInputAction: TextInputAction.done,
                  // decoration: const InputDecoration(

                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purpleAccent, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                           ),
                        enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.purple, width: 2.0),
                          borderRadius: BorderRadius.circular(20.0),
                      ),

                    hintText: 'password',
                      hintStyle: TextStyle(color: Colors.purpleAccent),
                  prefixIcon: Icon(Icons.lock, color: Colors.purpleAccent),
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: Colors.purple
                      ),),
                        ),
                ),
                   ElevatedButton(
                    onPressed: () async {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      final user = User(email, password);
                      if (await _usersRepository.contains(user)) {
                        await _sessionManager.saveSession(user);
                        Navigator.pushReplacementNamed(context, '/home', arguments: email);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Wrong email or password'),
                          ),
                    );
                  }
                },
                    child: const Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/sign_up');
                },
                child: const Text('Firstly here? Sign up!', style: TextStyle(fontSize: 15.0,),
              ),
              )],
          ),
      ),
      );
  }
}