import 'package:dart_notes_mobile/src/blocs/auth_bloc.dart';
import 'package:dart_notes_mobile/src/blocs/bloc_provider.dart';
import 'package:dart_notes_mobile/src/models/state/auth_state.dart';
import 'package:flutter/material.dart';
import '../actions/actions.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key key}) : super(key: key);

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    authBloc.state.listen((state) async {
      if (state != null) {
        if (state is AuthorizedState) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(state.message),
            duration: const Duration(seconds: 1),
          ));
          await Future.delayed(const Duration(seconds: 1));
          Navigator.of(context).pushReplacementNamed('/home');
        } else if (state is AuthErrorState) {
          _scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(state.message),
            duration: const Duration(seconds: 1),
          ));
        }
      }
    });

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Dart notes"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.solid,
                  ),
                ),
                hintText: 'Username',
                contentPadding: const EdgeInsets.all(8),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.solid,
                  ),
                ),
                hintText: 'Password',
                contentPadding: const EdgeInsets.all(8),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  child: Text("SignIn"),
                  onPressed: () async {
                    authBloc.action.add(LogInAction(
                      username: _usernameController.text.trim(),
                      password: _passwordController.text.trim(),
                    ));
                  },
                ),
                RaisedButton(
                  child: Text("SignUp"),
                  onPressed: () async {
                    authBloc.action.add(SignInAction(
                      username: _usernameController.text.trim(),
                      password: _passwordController.text.trim(),
                    ));
                  },
                ),
                RaisedButton(
                  child: Text("Offline mode"),
                  onPressed: () async {
                    authBloc.action.add(OfflineAuthAction());
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
