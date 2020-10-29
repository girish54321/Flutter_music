import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/provider/loginState.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Column buildDisplayNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Text(
              "Display Name",
              style: TextStyle(color: Colors.grey),
            )),
        TextField(
          // controller: displayNameController,
          decoration: InputDecoration(
            hintText: "Update Display Name",
            // errorText: _displayNameValid ? null : "Display Name too short",
          ),
        )
      ],
    );
  }

  Column buildBioField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Bio",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          // controller: bioController,
          decoration: InputDecoration(
            hintText: "Update Bio",
            // errorText: _bioValid ? null : "Bio too long",
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Edit Profile",
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.done,
              size: 30.0,
            ),
          ),
        ],
      ),
      body: Consumer<LoginStateProvider>(
        builder: (context, loginStateProvider, child) {
          return loginStateProvider.user != null
              ? ListView(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: 16.0,
                              bottom: 8.0,
                            ),
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: CachedNetworkImageProvider(
                                  "https://wallpapercave.com/wp/wp6031453.jpg"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: <Widget>[
                                buildDisplayNameField(),
                                buildBioField(),
                              ],
                            ),
                          ),
                          RaisedButton(
                            // onPressed: updateProfileData,
                            onPressed: () {},
                            child: Text(
                              "Update Profile",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Consumer<LoginStateProvider>(
                            builder: (context, loginStateProvider, child) {
                              return Padding(
                                padding: EdgeInsets.all(16.0),
                                child: FlatButton.icon(
                                  onPressed: () async {
                                    // await FirebaseAuth.instance.signOut();
                                    // loginStateProvider.changeLoginState(false);
                                    // loginStateProvider.saveUserFavSong();
                                    loginStateProvider.allDataFav();
                                  },
                                  icon: Icon(Icons.cancel, color: Colors.red),
                                  label: Text(
                                    "Logout",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 20.0),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Text("Name");
        },
      ),
    );
  }
}
