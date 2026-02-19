import 'package:api_project/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    nameController = TextEditingController(
      text: userProvider.getUser.user!.name.toString(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Column(
        children: [
          TextField(
            decoration: InputDecoration(labelText: "Name"),
            controller: nameController,
          ),

          SizedBox(height: 20),
          isLoading
              ? Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  onPressed: () async {
                    isLoading = true;
                    setState(() {});
                    try {
                      await AuthServices()
                          .updateUser(
                            token: userProvider.getToken.toString(),
                            name: nameController.text,
                          )
                          .then((value) async {
                            await AuthServices()
                                .getUser(userProvider.getToken.toString())
                                .then((val) {
                                  isLoading = false;
                                  setState(() {});

                                  userProvider.setUser(val);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Profile updated successfully",
                                      ),
                                    ),
                                  );
                                });
                          });
                    } catch (e) {
                      isLoading = false;
                      setState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to update profile: $e")),
                      );
                    }
                  },
                  child: Text("Save Changes"),
                ),
        ],
      ),
    );
  }
}
