import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final fromKey = GlobalKey<FormState>();
  bool isObscureText = true;
  String errMsg = '';
  
  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: fromKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 200,horizontal: 20),
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  prefixIcon: Icon(Icons.email,
                  color: Theme.of(context).primaryColor,),
                  filled: true,
                ),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: passController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock,
                    color: Theme.of(context).primaryColor,),
                  suffixIcon: IconButton(
                    icon: Icon(isObscureText ? Icons.visibility_off:Icons.visibility),
                    onPressed: (){
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                  ),
                  filled: true,
                ),
                validator: (value){
                  if(value==null || value.isEmpty){
                    return 'please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){
                    authenticate();
                  }, 
                  child: const Text('LOGIN'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Forgot Password?',style: TextStyle(fontSize: 12),),
                  TextButton(
                    onPressed: (){}, 
                    child: const Text('Click here...'),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Text(errMsg,style: TextStyle(color: Theme.of(context).errorColor),)
            ],
          ),
        )
      ),
    );
  }

  void authenticate() {}
}
