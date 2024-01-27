import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_authentication/services/firebase_service.dart';
import 'package:firebase_authentication/util/catdata.dart';
import 'package:firebase_authentication/util/catitem.dart';
import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  Color btnSimpanColorDefault = Colors.blue;

  Color btnSimpanColor = Colors.blue;

  Color btnUbahColor = Colors.blueGrey;

  String btnSimpanTextDefault = "Simpan";

  String btnSimpanText = "Simpan";

  String btnUbahText = "Ubah";

  int selectedDaftarUserIndex = 0;

  FirebaseService firebaseService = new FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                'Cat',
                style: TextStyle(
                  color: Color(0xff33394e),
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
              Text(
                'Fact',
                style: TextStyle(
                  color: Colors.black45,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          Text(
            'Favorite fact about cats!!!',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: firebaseService.index(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text('No data available');
                }
                return ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    CatData catData =
                        new CatData(documentSnapshot['statement']);
                    return Dismissible(
                      key: ValueKey(catData),
                      child: InkWell(
                        child: CatItem(catData),
                        onTap: () {
                          btnSimpanColor = btnUbahColor;
                          btnSimpanText = btnUbahText;
                          setState(() {
                            btnSimpanColor;
                            btnSimpanText;
                          });
                          selectedDaftarUserIndex = index;
                        },
                      ),
                      background: Container(
                        padding: EdgeInsets.only(left: 25),
                        color: Colors.red,
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            )),
                      ),
                      secondaryBackground: Container(
                        color: Colors.white,
                      ),
                      dismissThresholds: {DismissDirection.startToEnd: 0.2},
                      onDismissed: (direction) {
                        firebaseService.delete(catData);
                      },
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Confirm"),
                                content: const Text(
                                    "Are you sure you wish to delete this item?"),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(true),
                                      child: const Text("DELETE")),
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("CANCEL"),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          return false;
                        }
                      },
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: snapshot.data!.docs.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
