import 'package:crud_shop/domain/models/user_model.dart';
import 'package:crud_shop/presentation/providers/auth_provider.dart';
import 'package:crud_shop/presentation/widgets/text_form_field/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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

  bool _isLoading =  false;

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
    final bool isSignUp = context.watch<AuthProvider>().isSignUpComplete;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isSignUp) {
        setState(() => _isLoading = false);
        authProvider.resetFlags();
        context.push('/login');
      }
    });

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(strokeWidth: 3),
      );
    }

    void validations({
      required String password,
      required String confirmPassword,
      required String email,
      required String userName
    }) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

      if (password != confirmPassword) throw ErrorHint('Las contraseñas no coinciden');
      if (email == '' || userName == '' || password == '') throw ErrorHint('Todos los campos son obligatorios');
      if (!emailRegex.hasMatch(email)) throw ErrorHint('Email no valido');
    }

    void signUp({
      required String password,
      required String confirmPassword,
      required String email,
      required String userName
    }) async {
      List<String> registrationTokenList = [
        'provisional'
      ];

      try {
        validations(
          password: password, 
          confirmPassword: confirmPassword, 
          email: email, 
          userName: userName
        );

        UserModel newUser = UserModel(
          userName: userName, 
          email: email, 
          password: password, 
          registrationTokenList: registrationTokenList
        );
        await authProvider.signUp(newUser);
      } catch (e) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    void updateControllers() {
      setState(() => _isLoading = true);
      String userName = _userController.text;
      _userController.text = '';
  
      String password = _passwordController.text;
      _passwordController.text = '';

      String email = _emailController.text;
      _emailController.text = '';

      String confirmPassword = _confirmPasswordController.text;
      _confirmPasswordController.text = '';

      signUp(
        password: password,
        confirmPassword: confirmPassword,
        email: email,
        userName: userName
      );
    }

    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
              child: Form(
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
                        onPressed: updateControllers,
                        child: const Text('Registrarse')
                      ),
                    ),

                    SizedBox(
                      height: 20.0,
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
              ),
            ),
          )
        ),
    );
  }
}