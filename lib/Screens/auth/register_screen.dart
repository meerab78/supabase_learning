import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_learning/Screens/home_page.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final email=TextEditingController();
  final password =TextEditingController();
  bool loading= false;
  final supabase = Supabase.instance.client;
  register() async {
    setState(() {
      loading=true;
    });
    try{
      final result = await supabase.auth.signUp(email:email.text, password: password.text);
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
      appBar: AppBar(title:Text('Register'),
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
            register();
          }, child: Text('Login')),
          SizedBox(height: 20,),
          TextButton(onPressed: (){}, child: Text("Already have an account? Login"))
        ],
      ),
    );
  }
}
