import 'package:flutter/material.dart';
import 'package:untitled12/models/contact.dart';
import 'package:untitled12/reposityory/contact_repository.dart';
import 'package:untitled12/ui/contact_add.dart';
import 'package:untitled12/ui/contact_detail.dart';
import 'package:untitled12/ui/widgets/custom_searchbar.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  // List<Contact> contacts = [];

  _loadContacts() async {
    List<Contact> newContacts = await DatabaseHelper.getContacts();
    setState(() {
      // contacts = newContacts;
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
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Sort by"),
              ),
              PopupMenuItem(
                  child: Text("Delete all"),
                  onTap: () {
                    DatabaseHelper.deleteContacts();
                    setState(() {});
                  }),
            ],
          )
        ],
      ),
      body: FutureBuilder(
        future: DatabaseHelper.getContacts(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(data[index].name + " " + data[index].surname),
                subtitle: Text(data[index].phoneNumber),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ContactDetail(contact: data[index]),
                      ));
                },
              ),
            );
          }
          return Center(child: Text('error'));
        },
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
