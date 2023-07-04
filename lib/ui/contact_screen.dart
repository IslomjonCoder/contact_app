import 'package:flutter/material.dart';
import 'package:untitled12/models/contact.dart';
import 'package:untitled12/reposityory/contact_repository.dart';
import 'package:untitled12/ui/contact_add.dart';
import 'package:untitled12/ui/widgets/custom_searchbar.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact> contacts = [];

  _loadContacts() async {
    List<Contact> newContacts = await DatabaseHelper.getContacts();
    setState(() {
      contacts = newContacts;
    });
    print('Contacts loaded');
  }

  @override
  void initState() {
    _loadContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        actions: [
          IconButton(
              onPressed: () {
                // showSearch(context: context, delegate: CustomSearchDelegate());
                // DatabaseHelper.deleteContacts();
                // _loadContacts();
              },
              icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
        ],
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(contacts[index].name + " " + contacts[index].surname),
          subtitle: Text(contacts[index].phoneNumber),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ContactAddScreen(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
