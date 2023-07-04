import 'package:flutter/material.dart';
import 'package:untitled12/models/contact.dart';
import 'package:untitled12/reposityory/contact_repository.dart';
import 'package:untitled12/ui/contact_edit.dart';

class ContactDetail extends StatelessWidget {
  ContactDetail({Key? key, required this.contact}) : super(key: key);
  Contact contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.account_circle,
                    size: 100,
                    color: Colors.grey,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                          onPressed: () {
                            DatabaseHelper.deleteContact(contact.id!);
                          },
                          icon: Icon(Icons.delete)),
                      IconButton(
                          onPressed: () {
                            ContactEditScreen(contact: contact);
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.black87,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              contact.name + ' ' + contact.surname,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  contact.phoneNumber.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.orange),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.chat,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
