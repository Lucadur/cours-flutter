// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/user_provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: const SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                LoginForm(),
                Divider(height: 40, color: Colors.orangeAccent),
                SignupForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est obligatoire';
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Entrez un email valide';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est obligatoire';
    }
    if (value.length < 8) {
      return 'Le mot de passe doit contenir au moins 8 caractères';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Connectez-vous',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _emailController,
            validator: _validateEmail,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orangeAccent),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            validator: _validatePassword,
            style: const TextStyle(color: Colors.white),
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Mot de passe',
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.orangeAccent),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_loginFormKey.currentState!.validate()) {
                final success = await userProvider.login(
                  _emailController.text,
                  _passwordController.text,
                );
                if (success) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Échec de la connexion')),
                  );
                }
              }
            },
            child: const Text('Se connecter'),
          ),
        ],
      ),
    );
  }
}

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _signupFormKey = GlobalKey<FormState>();
  final _emailSignupController = TextEditingController();
  final _passwordSignupController = TextEditingController();
  final _confirmPasswordSignupController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  void dispose() {
    _emailSignupController.dispose();
    _passwordSignupController.dispose();
    _confirmPasswordSignupController.dispose();
    _lastNameController.dispose();
    _firstNameController.dispose();
    _addressController.dispose();
    _zipCodeController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est obligatoire';
    }
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Entrez un email valide';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est obligatoire';
    }
    if (value.length < 8) {
      return 'Le mot de passe doit contenir au moins 8 caractères';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ce champ est obligatoire';
    }
    if (value != _passwordSignupController.text) {
      return 'Les mots de passe ne correspondent pas';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Form(
      key: _signupFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Inscrivez-vous',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.orangeAccent,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Vos informations personnelles',
            style: TextStyle(
              fontSize: 16,
              color: Colors.orangeAccent,
            ),
          ),
          const SizedBox(height: 10),
          _buildTextField('Nom', _lastNameController),
          const SizedBox(height: 10),
          _buildTextField('Prénom', _firstNameController),
          const SizedBox(height: 10),
          _buildTextField('Adresse', _addressController),
          const SizedBox(height: 10),
          _buildTextField('Code postal', _zipCodeController),
          const SizedBox(height: 10),
          _buildTextField('Ville', _cityController),
          const SizedBox(height: 20),
          const Text(
            'Vos paramètres de connexion',
            style: TextStyle(
              fontSize: 16,
              color: Colors.orangeAccent,
            ),
          ),
          const SizedBox(height: 10),
          _buildTextField('Email', _emailSignupController,
              validator: _validateEmail),
          const SizedBox(height: 10),
          _buildTextField('Mot de passe', _passwordSignupController,
              obscureText: true, validator: _validatePassword),
          const SizedBox(height: 10),
          _buildTextField(
              'Confirmer le mot de passe', _confirmPasswordSignupController,
              obscureText: true, validator: _validateConfirmPassword),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (_signupFormKey.currentState!.validate()) {
                final success = await userProvider.register({
                  "email": _emailSignupController.text,
                  "password": _passwordSignupController.text,
                  "lastName": _lastNameController.text,
                  "firstName": _firstNameController.text,
                  "address": _addressController.text,
                  "postalCode": _zipCodeController.text,
                  "city": _cityController.text,
                  "roles": ["user"],
                });
                if (success) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Échec de l\'inscription')),
                  );
                }
              }
            },
            child: const Text('S\'inscrire'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool obscureText = false, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orangeAccent),
        ),
      ),
    );
  }
}
