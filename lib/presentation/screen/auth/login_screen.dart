import 'package:crud_shop/presentation/providers/auth_provider.dart';
import 'package:crud_shop/presentation/widgets/text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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

  bool _isLoading = false;

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
    AuthProvider authProvider = context.read<AuthProvider>();
    final bool isLogIn = context.watch<AuthProvider>().isLogIn;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLogIn) {
        setState(() => _isLoading = false);
        authProvider.resetFlags();
        context.go('/home');
      }
    });
    
    return FutureBuilder(
      future: context.read<AuthProvider>().checkLogin(),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting || _isLoading) {
          return Center(
            child: CircularProgressIndicator(strokeWidth: 3, ),
          );
        }

        return SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 0),
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
                            labelText: 'Correo electrónico',
                          ),
                    
                          SizedBox(
                            height: 20.0,
                          ),
                    
                          CustomTextFormField(
                            controller: _passwordController, 
                            focusNode: _passwordFocus, 
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
                              onPressed: () async {
                                setState(() => _isLoading = true);
                                String email = _userController.text;
                                _userController.text = '';
                            
                                String password = _passwordController.text;
                                _passwordController.text = '';
                            
                                try {
                                  await authProvider.login(email, password);
                                } catch (e) {
                                  setState(() => _isLoading = false);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('$e'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                }
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
                      context.push('/signup');
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
    );
  }
}