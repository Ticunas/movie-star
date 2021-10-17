import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:movie_star/core/errors/failures.dart';
import 'package:movie_star/core/presentation/widgets/snack_bar_factory.dart';
import 'package:movie_star/features/login/presentation/login_controller.dart';
import 'package:movie_star/features/login/presentation/stores/save_credential_store.dart';

class LoginPage extends StatefulWidget {
  final SaveCredentialStore saveCredentialStore;

  const LoginPage({
    Key? key,
    required this.saveCredentialStore,
  }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  _LoginPageState();
  late ScaffoldMessengerState _scaffoldMessenger;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  List<ReactionDisposer>? _disposers;
  @override
  Widget build(BuildContext context) {
    _scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    CircleAvatar(
                      radius: 30,
                      child: Icon(
                        Icons.account_circle_rounded,
                        size: 60,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _nameTextController,
                  validator: (value) {
                    return LoginValidation.isInvalidName(value)
                        ? 'Name Required'
                        : null;
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Name',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                    controller: _emailTextController,
                    validator: (value) {
                      return LoginValidation.isInvalidEmail(value)
                          ? 'Please Enter a valid email'
                          : null;
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      labelText: 'E-mail',
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _validateForm();
                            _saveCredential(_nameTextController.text,
                                _emailTextController.text);
                          });
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _disposers = [
      //Used to call Home page when credentrials is created successful
      when(
          (_) => widget.saveCredentialStore.credential != null,
          () => {
                //TODO call HomePage
              }),

      //if any error occours trying save credential
      reaction(
          (_) => widget.saveCredentialStore.failure,
          (Failure? failure) => {
                if (failure != null)
                  {
                    _scaffoldMessenger.showSnackBar(buildSnackBarError(
                        '${failure.getMessage()}, code: ${failure.getCode()}',
                        _scaffoldMessenger))
                  }
              })
    ];
    super.didChangeDependencies();
  }

  void _validateForm() {
    final isValid = _formKey.currentState?.validate();
    if (isValid == null || !isValid) {
      return;
    }
  }

  void _saveCredential(String name, String email) {
    widget.saveCredentialStore.saveCredential(name, email);
  }
}
