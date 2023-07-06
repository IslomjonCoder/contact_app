import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:untitled12/models/contact.dart';
import 'package:untitled12/repository/contact_repository.dart';
import 'package:untitled12/ui/contact_screen.dart';
import 'package:untitled12/ui/widgets/custom_input_widget.dart';

class ContactAddScreen extends StatefulWidget {
  ContactAddScreen({Key? key}) : super(key: key);

  // Contact? contact;
  @override
  State<ContactAddScreen> createState() => _ContactAddScreenState();
}

class _ContactAddScreenState extends State<ContactAddScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController surnameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // nameController.text = widget.contact.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add'),
        actions: [
          TextButton(
            onPressed: () {
              if (nameController.text.length > 0 &&
                  phoneController.text.length > 0) {
                DatabaseHelper.insertContact(Contact(
                    name: nameController.text,
                    surname: surnameController.text,
                    phoneNumber: "+998 " + phoneController.text));
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactScreen(),
                    ));
              } else {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Fields are empty')));
              }
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            InputTextField(
              label: 'Name',
              hint: 'Enter name',
              controller: nameController,
              actionType: TextInputAction.next,
            ),
            InputTextField(
              label: 'Surname',
              hint: 'Enter surname',
              controller: surnameController,
            ),
            InputTextField(
              label: 'Phone number',
              hint: '_ _   _ _ _   _ _   _ _',
              inputType: TextInputType.phone,
              controller: phoneController,
              actionType: TextInputAction.done,
              inputFormatters: [
                MaskTextInputFormatter(
                  mask: '## ### ## ##',
                  filter: {"#": RegExp(r'[0-9]')},
                )
              ],
              prefixText: "+998",
            ),
          ],
        ),
      ),
    );
  }
}
