import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tt9_betweener_challenge/controllers/auth_controller.dart';
import 'package:tt9_betweener_challenge/views/profile_view.dart';
import 'package:tt9_betweener_challenge/views/widgets/custom_text_form_field.dart';

import '../controllers/edit_profile_cont.dart';
import '../models/user.dart';

class EditProfile extends StatefulWidget {
  static const id = '/editprofile';

  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<bool>? SaveNewLink() {
    if (_formKey.currentState!.validate()) {
      final body = {
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneContoller.text
      };
      print(body['name']);
      print(body['email']);
      print('test enter');

      login(body).then((user) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', userToJson(user));
        print('tennn');
        // if (mounted) {
        //   Navigator.pushNamed(context, MainAppView.id);
        // }
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return ProfileView();
          }),
        );
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 28,
            color: Color(0xff2D2B4E),
          ),
        ),
        title: const Text('Edit User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // const SizedBox(
              //   height: 60,
              // ),
              const CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage('assets/imgs/download.jfif'),
              ),
              const SizedBox(
                height: 50,
              ),
              CustomTextFormField(
                controller: nameController,
                hint: 'RawndRajab',
                label: 'Name',
              ),
              const SizedBox(height: 28),
              CustomTextFormField(
                controller: emailController,
                hint: 'rajabrawnd@gmail.com',
                label: 'email',
              ),
              const SizedBox(height: 28),
              // CustomTextFormField(
              //   controller: phoneContoller,
              //   hint: '972592864781',
              //   label: 'Phone Number',
              // ),
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
                onPressed: () {
                  SaveNewLink();
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
