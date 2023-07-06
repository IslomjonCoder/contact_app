import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:untitled12/models/contact.dart';
import 'package:untitled12/repository/contact_repository.dart';
import 'package:untitled12/ui/contact_screen.dart';
import 'package:untitled12/ui/widgets/custom_input_widget.dart';

class ContactEditScreen extends StatefulWidget {
  ContactEditScreen({Key? key, required this.contact}) : super(key: key);
  Contact contact;

  @override
  State<ContactEditScreen> createState() => _ContactEditScreenState();
}

class _ContactEditScreenState extends State<ContactEditScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController surnameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    nameController.text = widget.contact.name;
    surnameController.text = widget.contact.surname;
    phoneController.text = widget.contact.phoneNumber.substring(4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update'),
        actions: [
          TextButton(
            onPressed: () {
              if (nameController.text.length > 0 &&
                  phoneController.text.length > 0) {
                DatabaseHelper.updateContact(Contact(
                  id: widget.contact.id,
                  name: nameController.text,
                  surname: surnameController.text,
                  phoneNumber: "+998 " + phoneController.text,
                ));
                Navigator.pop(context);
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
