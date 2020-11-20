import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/provider/loginState.dart';
import 'package:provider/provider.dart';
import 'package:musicPlayer/Compontes/dialogs.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
  }

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
          decoration: InputDecoration(
            hintText: "Update Display Name",
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
                            child: CachedNetworkImage(
                              placeholder: (context, url) => CircleAvatar(
                                radius: 66.0,
                                backgroundImage:
                                    AssetImage('assets/images/placholder.jpg'),
                              ),
                              imageUrl:
                                  "https://m.media-amazon.com/images/M/MV5BM2M2ZGE5NjItYjc2ZS00ZWYzLTk2MzEtZTc3YThhNzhiNmU4XkEyXkFqcGdeQXVyNTU0NDgwMzA@._V1_.jpg",
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                radius: 66.0,
                                backgroundImage: imageProvider,
                              ),
                              errorWidget: (context, url, error) => Container(
                                height: 150.0,
                                child: Icon(Icons.error),
                              ),
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
                                    final action = await Dialogs.yesAbortDialog(
                                        context, 'Log Out', 'Are You Sure ?');
                                    if (action == DialogAction.yes) {
                                      await FirebaseAuth.instance.signOut();
                                      loginStateProvider
                                          .changeLoginState(false);
                                    } else {}
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
