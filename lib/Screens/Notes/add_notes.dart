import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final title = TextEditingController();
  final description = TextEditingController();

  final supabase = Supabase.instance.client;
  bool loading = false;
  addnote() async{
    setState(() {
      loading=true;
    });
    try{
 await supabase.from('notes').insert({
   'title': title.text,
    'description': description.text,
  });
    }catch(e){
      print(e);
    }finally{
      setState(() {
        loading=false;
      });
    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notes')
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          TextFormField(
            controller: title,
            decoration: InputDecoration(
              hintText: 'Title'
            ),
          ),
          SizedBox(height: 20,),
          TextFormField(
            controller: description,
            decoration: InputDecoration(
                hintText: 'Description'
            ),
          ),
          SizedBox(height: 20,),
        loading? Center(child: CircularProgressIndicator(),):
        ElevatedButton(onPressed: (){
          addnote();
        }, child: Text('Add Note'))],
      ),
    );
  }
}
