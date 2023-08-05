// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/models/link.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';
import '../controllers/add_link_controllar.dart';
import '../controllers/link_controller.dart';
import '../models/user.dart';
import 'home_view.dart';
import 'main_app_view.dart';

class addLink extends StatefulWidget {
  static String id = '/addlink';

  const addLink({super.key});

  @override
  State<addLink> createState() => _addLinkState();
}

class _addLinkState extends State<addLink> {
  TextEditingController titleController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  TextEditingController userContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late Future<List<Link>> new_links;

  @override
  void dispose() {
    titleController.dispose();
    linkController.dispose();
    super.dispose();
  }

  
  Future<bool>? SaveNewLink() {
    if (_formKey.currentState!.validate()) {
      final body = {
        'title': titleController.text,
        'link': linkController.text,
        'username': userContoller.text
      };
      print(body['username']);

      AddNewLink(body).then((link) async {
        await Navigator.push(context, MaterialPageRoute(builder: (context){
          return const MainAppView();
        }
        )
        ,);
        return true;
      }).catchError((err) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(err.toString()),
          backgroundColor: Colors.red,
        ));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomeView();
            }));          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 28,
            color: Color(0xff2D2B4E),
          ),
        ),
        title: const Text('Add Link'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              CustomTextFormField(
                controller: titleController,
                hint: 'Snapchat',
                label: 'title',
              ),
              const SizedBox(height: 28),
              CustomTextFormField(
                controller: linkController,
                hint: 'http:\\www.Example.com',
                label: 'Link',
              ),
              const SizedBox(height: 28),
              CustomTextFormField(
                controller: userContoller,
                hint: '@Rawnd',
                label: 'User Name:',
              ),
              const SizedBox(height: 28),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          15,
                        ),
                      ),
                    ),
                  ),
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 60,
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xffFFD465),
                  ),
                ),
                onPressed: () async {
                  SaveNewLink();
                  //  await  SaveNewLink()== true ? Navigator.pop(context):print('errroe');
                },
                child: const Text(
                  'ADD',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff784E00),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
