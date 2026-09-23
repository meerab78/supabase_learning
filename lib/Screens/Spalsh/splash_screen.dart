import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_learning/Screens/auth/login_screen.dart';
import 'package:supabase_learning/Screens/home_page.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final supabase = Supabase.instance.client;
  nextScreen()async{
    await Future.delayed(Duration(seconds: 3));
    if(supabase.auth.currentSession==null){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => LoginScreen()));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => HomePage()));
    }
  }
  @override
  void initState() {
    nextScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(size: 150,),
      ),
    );
  }
}
