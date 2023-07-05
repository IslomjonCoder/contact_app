import 'package:flutter/material.dart';
import 'package:untitled12/models/contact.dart';
import 'package:untitled12/repository/contact_repository.dart';
import 'package:untitled12/ui/contact_edit.dart';
import 'package:untitled12/ui/contact_screen.dart';

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
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Delete contact'),
                                content: Text(
                                    'Are you sure you want to remove ${contact.name + ' ' + contact.surname} from your contacts?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        DatabaseHelper.deleteContact(
                                            contact.id!);
                                        Navigator.pop(context);
                                      },
                                      child: Text('No')),
                                  TextButton(
                                      onPressed: () {
                                        // DatabaseHelper.deleteContacts();
                                        DatabaseHelper.deleteContact(
                                            contact.id!);
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ContactScreen(),
                                            ));
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(color: Colors.red),
                                      )),
                                ],
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.black,
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ContactEditScreen(contact: contact),
                                ));
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
                    FloatingActionButton.small(
                      heroTag: 'call',
                      onPressed: () {},
                      child: Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.green,
                    ),
                    SizedBox(width: 15),
                    FloatingActionButton.small(
                      heroTag: 'message',
                      onPressed: () {},
                      child: Icon(
                        Icons.chat,
                        color: Colors.white,
                      ),
                      backgroundColor: Color(0xFFe9ad13),
                    )
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
