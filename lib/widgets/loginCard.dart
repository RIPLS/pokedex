import 'package:flutter/material.dart';

import 'button.dart';

enum AuthMode { Signup, Login }

class LoginCard extends StatefulWidget {
  final Function _setAuth;

  LoginCard(this._setAuth);

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  final formKey = GlobalKey<FormState>();

  final _userFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmpasswordFocusNode = FocusNode();

  bool _obscureText = true;
  bool _confirmobscureText = true;

  AuthMode _authMode;

  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authMode = AuthMode.Login;
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _userFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmpasswordFocusNode.dispose();
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String _username, _password;

    Future<void> submitdata() async {
      if (!formKey.currentState.validate()) {
        return;
      }
      formKey.currentState.save();
      widget._setAuth(_username, _password);
    }

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 20),
        child: Container(
          height: _authMode == AuthMode.Signup ? 330 : 250,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextFormField(
                  maxLines: 1,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person, color: Colors.black26),
                      labelText: 'User'),
                  focusNode: _userFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_passwordFocusNode);
                  },
                  onSaved: (val) => _username = val,
                  validator: (uservalue) {
                    if (uservalue.isEmpty) {
                      return 'Plase enter User';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLines: 1,
                  controller: _passwordController,
                  obscureText: _obscureText,
                  textInputAction: _authMode == AuthMode.Login
                      ? TextInputAction.done
                      : TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                      icon: Icon(Icons.vpn_key, color: Colors.black26),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: _obscureText
                            ? Icon(
                                Icons.visibility,
                                color: Colors.grey,
                              )
                            : Icon(Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )),
                  focusNode: _passwordFocusNode,
                  onFieldSubmitted: (_) {
                    _authMode == AuthMode.Login
                        ? submitdata()
                        : FocusScope.of(context)
                            .requestFocus(_confirmpasswordFocusNode);
                  },
                  onSaved: (val) {
                    _password = val;
                  },
                  validator: (value) {
                    if (value.isEmpty ||
                        (_authMode == AuthMode.Login
                            ? false
                            : value.length < 5)) {
                      return _authMode == AuthMode.Login
                          ? 'Plase enter Password'
                          : 'Password is too short';
                    }
                    return null;
                  },
                ),
                _authMode == AuthMode.Login
                    ? Container()
                    : TextFormField(
                        maxLines: 1,
                        obscureText: _confirmobscureText,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                            icon: Icon(Icons.fiber_new, color: Colors.black26),
                            labelText: 'Confirm Password',
                            suffixIcon: IconButton(
                              icon: _confirmobscureText
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.grey,
                                    )
                                  : Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _confirmobscureText = !_confirmobscureText;
                                });
                              },
                            )),
                        focusNode: _confirmpasswordFocusNode,
                        onFieldSubmitted: (_) {
                          submitdata();
                        },
                        validator: _authMode == AuthMode.Signup
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              }
                            : null,
                      ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ButtonWidget(
                          buttonColor: Colors.indigo[900],
                          buttonFunction: submitdata,
                          buttonText: _authMode == AuthMode.Login
                              ? 'Login'
                              : 'Sign up'),
                      FlatButton(
                        child: Text(
                          _authMode == AuthMode.Login ? 'Register' : 'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        onPressed: () {
                          _switchAuthMode();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
