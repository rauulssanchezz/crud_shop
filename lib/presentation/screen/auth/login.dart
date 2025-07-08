import 'package:crud_shop/presentation/widgets/text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de sesión'),
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

  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              Expanded(
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        controller: _userController, 
                        focusNode: _userFocus, 
                        isPassword: false,
                        onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocus),
                        labelText: 'Nombre de usuario',
                      ),
                
                      SizedBox(
                        height: 20.0,
                      ),
                
                      CustomTextFormField(
                        controller: _passwordController, 
                        focusNode: _userFocus, 
                        isPassword: true,
                        onFieldSubmitted: (_) => _passwordFocus.unfocus(),
                        labelText: 'Contraseña',
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
                        
                            print('User: $userName, Password: $password');
                          },
                          child: const Text('Iniciar Sesión')
                        ),
                      )
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  
                },
                child: Text(
                  '¿No tienes una cuenta? ¡Regístrate!',
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