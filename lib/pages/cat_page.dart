import 'package:firebase_authentication/auth.dart';
import 'package:firebase_authentication/controllers/data_controller.dart';
import 'package:firebase_authentication/pages/favorite_page.dart';
import 'package:firebase_authentication/pages/login_page.dart';
import 'package:firebase_authentication/services/firebase_service.dart';
import 'package:firebase_authentication/util/catdata.dart';
import 'package:firebase_authentication/widgets/rounded_container.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class CatPage extends StatelessWidget {
  final DataController dataController = Get.put(DataController());

  FirebaseService firebaseService = new FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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
              'Random fact about cats!!!',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 20,
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () {
                        if (dataController.isLoading.value) {
                          return const RoundedContainer(title: "...");
                        } else if (dataController.fact.value.isNotEmpty) {
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirm"),
                                    content: const Text(
                                        "Are you sure you want to add to favorite?"),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          CatData statement = new CatData(
                                              dataController.fact.value);
                                          firebaseService.add(statement);
                                        },
                                        child: const Text("YES"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: const Text("NO"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: RoundedContainer(
                              title: dataController.fact.value,
                            ),
                          );
                        } else {
                          return const Text('Failed to fetch data');
                        }
                      },
                    ),
                    GestureDetector(
                      onTap: () => dataController.fetchDataCat(),
                      child: Lottie.asset(
                        'assets/cat.json',
                        height: 250,
                        width: 250,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
