import 'package:flutter/material.dart';
import 'package:untitled12/models/contact.dart';
import 'package:untitled12/reposityory/contact_repository.dart';
import 'package:untitled12/ui/contact_screen.dart';
import 'package:untitled12/ui/widgets/custom_input_widget.dart';

class ContactAddScreen extends StatelessWidget {
  ContactAddScreen({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add'),
        actions: [
          IconButton(
              onPressed: () {
                if (nameController.text.length > 0 &&
                    phoneController.text.length > 0) {
                  DatabaseHelper.insertContact(Contact(
                      name: nameController.text,
                      surname: surnameController.text,
                      phoneNumber: phoneController.text));
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactScreen(),
                      ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Fields are empty')));
                }
              },
              icon: Icon(Icons.done))
        ],
      ),
      body: Column(
        children: [
          InputTextField(
            label: 'Name',
            hint: 'Enter name',
            controller: nameController,
          ),
          InputTextField(
            label: 'Surname',
            hint: 'Enter surname',
            controller: surnameController,
          ),
          InputTextField(
            label: 'Phone number',
            hint: '+998  _ _   _ _ _   _ _   _ _',
            inputType: TextInputType.phone,
            controller: phoneController,
          ),
        ],
      ),
    );
  }
}
