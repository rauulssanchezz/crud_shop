import 'package:crud_shop/presentation/widgets/text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
        centerTitle: true, 
      ),

      body: _Form(),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final FocusNode _userFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _userFocus.dispose();
    _passwordFocus.dispose();
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomTextFormField(
                      controller: _userController, 
                      focusNode: _userFocus, 
                      isPassword: false,
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_emailFocus),
                      labelText: 'Nombre de usuario',
                    ),
              
                    SizedBox(
                      height: 20.0,
                    ),
              
                    CustomTextFormField(
                      controller: _emailController, 
                      focusNode: _emailFocus, 
                      isPassword: false,
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocus),
                      labelText: 'Correo electrónico',
                    ),
              
                    SizedBox(
                      height: 20.0,
                    ),
              
                    CustomTextFormField(
                      controller: _passwordController, 
                      focusNode: _passwordFocus, 
                      isPassword: true,
                      onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_confirmPasswordFocus),
                      labelText: 'Contraseña',
                    ),
              
                    SizedBox(
                      height: 20.0,
                    ),
              
                    CustomTextFormField(
                      controller: _confirmPasswordController, 
                      focusNode: _confirmPasswordFocus, 
                      isPassword: true,
                      onFieldSubmitted: (_) => _confirmPasswordFocus.unfocus(),
                      labelText: 'Confirmar contraseña',
                    ),
              
                    SizedBox(
                      height: 20.0,
                    ),
              
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          String userName = _userController.text;
                          _userController.text = '';
                      
                          String password = _passwordController.text;
                          _passwordController.text = '';
              
                          String email = _emailController.text;
                          _emailController.text = '';
              
                          String confirmPassword = _confirmPasswordController.text;
                          _confirmPasswordController.text = '';
                      
                          print('User: $userName, Email: $email,  Password: $password, ConfirmPassword: $confirmPassword');
                        },
                        child: const Text('Registrarse')
                      ),
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  context.push('/login');
                },
                child: Text(
                  '¿Ya tienes una cuenta? Inicia sesión!',
                  style: TextStyle(
                    color: Color.fromRGBO(156, 112, 74, 1)
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}