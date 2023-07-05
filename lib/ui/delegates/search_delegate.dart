import 'package:flutter/material.dart';
import 'package:untitled12/models/contact.dart';
import 'package:untitled12/repository/contact_repository.dart';
import 'package:untitled12/ui/contact_detail.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() {
    _loadContacts();
  }
  _loadContacts() async {
    contacts = await DatabaseHelper.getContacts();
  }

  List<Contact> contacts = [];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in contacts) {
      if ((fruit.name + " " + fruit.surname)
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matchQuery.add(fruit.name);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {},
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Contact> matchQuery = [];
    for (var contact in contacts) {
      if ((contact.name + " " + contact.surname)
          .toLowerCase()
          .contains(query.toLowerCase())) {
        matchQuery.add(contact);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result.name + ' ' + result.surname),
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
              return ContactDetail(contact: result);
            }));
          },
        );
      },
    );
  }
}
