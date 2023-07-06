import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:untitled12/models/contact.dart';
import 'package:untitled12/repository/contact_repository.dart';
import 'package:untitled12/repository/contact_repository.dart';
import 'package:untitled12/ui/contact_add.dart';
import 'package:untitled12/ui/contact_detail.dart';
import 'package:untitled12/ui/widgets/custom_searchbar.dart';
import 'package:url_launcher/url_launcher.dart';

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
          IconButton(
              onPressed: () {
                return showTopSnackBar(
                  snackBarPosition: SnackBarPosition.bottom,
                  Overlay.of(context),
                  CustomSnackBar.success(
                    message:
                        "Good job, your release is successful. Have a nice day",
                  ),
                );
              },
              icon: Icon(Icons.notifications)),
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              icon: Icon(Icons.search)),
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Sort by"),
              ),
              PopupMenuItem(
                  child: Text(
                    "Delete all",
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    Future.delayed(
                        Duration(seconds: 0),
                        () => showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Delete everything?'),
                                content: Text(
                                    'Are you sure you want to remove everything'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('No')),
                                  TextButton(
                                      onPressed: () {
                                        DatabaseHelper.deleteContacts();
                                        Navigator.pop(context);
                                        setState(() {});
                                      },
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(color: Colors.red),
                                      )),
                                ],
                              ),
                            ));
                    setState(() {});

                    // DatabaseHelper.deleteContacts();
                    // setState(() {});
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
            return (data.length == 0)
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieBuilder.asset(
                          'assets/lottie/116469-no-item-in-box.json'),
                      Text('no data'),
                    ],
                  ))
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(data[index].name + " " + data[index].surname),
                      subtitle: Text(data[index].phoneNumber),
                      trailing: IconButton(
                        onPressed: () {
                          launch('tel:${data[index].phoneNumber}');
                        },
                        icon: Icon(
                          Icons.call,
                          color: Colors.green,
                        ),
                      ),
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
