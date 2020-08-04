import 'package:dart_notes_mobile_v3/src/actions/actions.dart';
import 'package:dart_notes_mobile_v3/src/blocs/bloc_provider.dart';
import 'package:dart_notes_mobile_v3/src/blocs/core_bloc.dart';
import 'package:dart_notes_mobile_v3/src/models/state/user_state.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CoreBloc coreBloc = BlocProvider.of<CoreBloc>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Container(
                  color: Theme.of(context).primaryColor,
                  height: 24,
                ),
                Container(
                  height: Scaffold.of(context).appBarMaxHeight - 24,
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 8),
                      Icon(
                        Icons.account_circle,
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      StreamBuilder(
                        stream: coreBloc.userBloc.state,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final _user = (snapshot.data as UserState).user;
                            return Text(_user.username);
                          } else {
                            coreBloc.action.add(LoadUserAction());
                            return Container();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: FlatButton(
              child: Text("SignOut"),
              onPressed: () {
                coreBloc.action.add(SignOutUserAction());
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/auth');
              },
            ),
          )
        ],
      ),
    );
  }
}
