import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_learning/Screens/auth/register_screen.dart';
import 'package:supabase_learning/Screens/home_page.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email=TextEditingController();
  final password =TextEditingController();
  bool loading= false;
  final supabase = Supabase.instance.client;
  login() async {
    setState(() {
      loading=true;
    });
    try{
 final result = await supabase.auth.signInWithPassword(email:email.text, password: password.text);
 if(result.user != null &&result.session !=null){
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()
   ));
 }
    }catch(e){
      print(e.toString());
    }
    finally{
      setState(() {
        loading=false;
      });
  }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Login'),
    ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          TextFormField(
            controller: email,
            decoration: InputDecoration(
              hintText:'Email',
            ),
          ),
          SizedBox(height: 15,),
          TextFormField(
            controller: password,
            decoration: InputDecoration(
              hintText:'Password',
            ),
          ),
          SizedBox(height: 20,),
          loading? Center(child: CircularProgressIndicator(),):
          ElevatedButton(onPressed: (){
            login();
          }, child: Text('Login')),
          SizedBox(height: 20,),
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) =>RegisterScreen()
            )
            );
          }, child: Text("Don't have an account? Regiter"))
        ],
      ),
    );
  }
}
