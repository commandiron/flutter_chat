import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {

  final Function(
    String email,
    String username,
    String password,
    bool isLogin
  ) submitAuthForm;

  final bool isLoading;

  AuthForm(this.submitAuthForm, this.isLoading);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _userEmail;
  String _userName;
  String _userPassword;

  void _submit() {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState.validate();
    if(isValid) {
      _formKey.currentState.save();

      widget.submitAuthForm(
        _userEmail.trim(),
        _userName?.trim(),
        _userPassword.trim(),
        _isLogin
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  key: ValueKey("email"),
                  validator: (value) {
                    if(value.isEmpty || !value.contains("@")) {
                      return "Please enter a valid email address.";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email Address",
                  ),
                  onSaved: (newValue) {
                    _userEmail = newValue;
                  },
                ),
                if(!_isLogin)
                  TextFormField(
                    key: ValueKey("username"),
                    validator: (value) {
                      if(value.isEmpty || value.length < 4) {
                        return "Please enter least 4 characters.";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Username",
                    ),
                    onSaved: (newValue) {
                      _userName = newValue;
                    },
                  ),
                TextFormField(
                  key: ValueKey("password"),
                  validator: (value) {
                    if(value.isEmpty || value.length < 6) {
                      return "Password must be at least 6 characters long.";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                  ),
                  obscureText: true,
                  onSaved: (newValue) {
                    _userPassword = newValue;
                  },
                ),
                SizedBox(height: 12,),
                widget.isLoading
                  ? Transform.scale(scale: 0.75, child: CircularProgressIndicator())
                  : Column(
                    children: [
                      ElevatedButton(
                        onPressed: _submit,
                        child: Text(_isLogin ? "Login" : "Signup")
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin ? "Create new account" : "I already have an account")
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
