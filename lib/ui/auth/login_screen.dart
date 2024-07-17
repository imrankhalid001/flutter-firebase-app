
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase_app/ui/auth/signup_screen.dart';
import 'package:flutter_firebase_app/widgets/round_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


 final _formKey = GlobalKey<FormState>();
 final emailController = TextEditingController();
 final passwordController = TextEditingController();

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

  }



  @override
  Widget build(BuildContext context) {

    // change this function 
    return WillPopScope(

      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },

      child: Scaffold(
      
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login'),
        ),
      
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
      
              Form(
                
                key: _formKey,
                child: Column(
                  children: [
      
      
                    // email text field
                       TextFormField(
                        keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.alternate_email) 
                ),
      
                validator: (value){
                  if(value!.isEmpty)
                  {
                    return 'please enter email';
                  }
      
                  return null;
                },
              ),
      
             const SizedBox(height: 10,),
              
                    
                    // password text field
                      TextFormField(
                         keyboardType: TextInputType.text,
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock_open_outlined) 
                ),
      
                   validator: (value){
                  if(value!.isEmpty)
                  {
                    return 'please enter password';
                  }
      
                  return null;
                },
      
              ),
      
                  ],
                )
                
                ),
      
      
      
           
      
             const SizedBox(height: 50,),
      
              
              RoundButton(
                title: "Login",
                onTap: (){
      
                  if(_formKey.currentState!.validate()){
      
                  }
      
                },
                
              ),
      
                const SizedBox(height: 50,),
      
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(onPressed: (){
      
                      Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context)=> SignUpScreen()
                      )
                      
                      );
      
                    }, child: Text("Sign up"))
                  ],
                )
      
          
            ],
          ),
        ),
      
      
      ),
    );
  }
}