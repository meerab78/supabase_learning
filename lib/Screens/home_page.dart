import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_learning/Screens/Notes/add_notes.dart';
import 'package:supabase_learning/Screens/auth/login_screen.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;
  List<Map<String,dynamic>> notes =[];
  bool loading = false;

  getnotes() async{
    setState(() {
      loading= true;
    });
    try{
 final result = await supabase.from('notes').select();
 setState(() {
   notes = result;
 });
    }catch(e){
      print(e);
    }finally{
      setState(() {
        loading= false;
      });
    }
  }
@override
  void initState() {
    getnotes();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        actions: [
          PopupMenuButton(itemBuilder: (context)=>[
            PopupMenuItem(onTap: ()async{
              await supabase.auth.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()),
                      (value)=>false);
            },
            child: Text('Logout'),)
          ])
        ],
      ),
      body:loading? Center(child: CircularProgressIndicator(),):ListView(
        children: [
        for(var note in notes)
          ListTile(
            title: Text(note['title']),
            subtitle: Text(note['description']),
            trailing: IconButton(onPressed: () async {
              await supabase.from('notes').delete().eq('id', note['id']);
            }, icon: Icon(Icons.delete)),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddNotes()));
      },
      child: Icon(Icons.add),
      ),
    );
  }
}
