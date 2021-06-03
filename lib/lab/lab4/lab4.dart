import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_vk/flutter_login_vk.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';
import 'package:vkio/main.dart';
import 'package:vkio/vk.dart';

VK vk;
Future getUsers() async {
  var response = await vk.api.friends.get({});
  print(response);
  print('echo');

  var friend = await vk.api.users.get({
    'user_ids': response['items'],
    'fields': ['photo_50', 'online']
  });

  return friend;
}

void main() {
  runApp(LabFourth());
}

class LabFourth extends StatefulWidget {
  final plugin = VKLogin(debug: true);

  LabFourth({Key key}) : super(key: key);

  @override
  _LabFourthState createState() => _LabFourthState();
}

class _LabFourthState extends State<LabFourth> {
  String _sdkVersion;
  VKAccessToken _token;
  VKUserProfile _profile;
  String _email;
  bool _sdkInitialized = false;
  bool _showFriends;

  @override
  void initState() {
    super.initState();
    _showFriends = true;
    _getSdkVersion();
    _initSdk();
  }

  @override
  Widget build(BuildContext context) {
    final token = _token;
    final profile = _profile;
    final isLogin = token != null;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
        child: Builder(
          builder: (context) => Center(
            child: Column(
              children: <Widget>[
                // if (_sdkVersion != null) Text('SDK v$_sdkVersion'),
                if (token != null && profile != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _buildUserInfo(context, profile, token, _email),
                  ),
                isLogin
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          OutlinedButton(
                              child: const Text('Друзья'),
                              onPressed: () async {
                                setState(() {
                                  getUsers().then((value) {
                                    var friend = value;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Scaffold(
                                                  appBar: AppBar(
                                                    title: Text(
                                                        "Друзья ${profile.firstName} ${profile.lastName}"),
                                                  ),
                                                  body: ListView.builder(
                                                    itemCount: friend.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int position) {
                                                      if (position.isOdd)
                                                        return new Divider();

                                                      //TITLE DATA
                                                      return ListTile(
                                                        contentPadding:
                                                            EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10.0,
                                                                    horizontal:
                                                                        7.0),
                                                        title: Text(
                                                          "${friend[position]['first_name']} ${friend[position]['last_name']}",
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                          ),
                                                        ),

                                                        //CIRCLE AVATAR LETTER
                                                        leading:
                                                            new CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(friend[
                                                                      position]
                                                                  ['photo_50']),
                                                          maxRadius: 30.0,
                                                        ),

                                                        //BODY DATA
                                                        subtitle: Text(
                                                          friend[position][
                                                                      'online'] ==
                                                                  1
                                                              ? "online"
                                                              : 'offline',
                                                          style: TextStyle(
                                                              color: friend[position]
                                                                          [
                                                                          'online'] ==
                                                                      1
                                                                  ? Colors
                                                                      .green[400]
                                                                  : Colors.grey,
                                                              fontSize: 18.0),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                )));
                                  });
                                });
                              }),
                          OutlinedButton(
                            child: const Text('Выйти'),
                            style: TextButton.styleFrom(primary: Colors.red),
                            onPressed: _onPressedLogOutButton,
                          ),
                        ],
                      )
                    : OutlineButton.icon(
                        label: const Text('Log in with VK',
                            style: TextStyle(
                              color: Colors.black,
                            )),
                        shape: StadiumBorder(),
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        highlightedBorderColor: Colors.black,
                        borderSide: BorderSide(color: Colors.black),
                        textColor: Colors.black,
                        icon: FaIcon(FontAwesomeIcons.vk,
                            color: Colors.blue[900]),
                        onPressed: () => _onPressedLogInButton(context),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfo(BuildContext context, VKUserProfile profile,
      VKAccessToken accessToken, String email) {
    final photoUrl = profile.photo100;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Вы зашли как: ',
            style: TextStyle(fontSize: 20),
          ),
          Text(
            '${profile.firstName} ${profile.lastName}',
            style: const TextStyle(
                fontSize: 18, fontFamily: 'Arial', fontWeight: FontWeight.bold),
          ),
          if (photoUrl != null)
            Container(
              margin: EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  photoUrl,
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.laptop),
              Container(
                width: 10,
                height: 10,
                child: RawMaterialButton(
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: profile.online ? Colors.green : Colors.red,
                  padding: EdgeInsets.all(1.0),
                  shape: CircleBorder(),
                  focusColor: Colors.black,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.phone_android_outlined),
              Container(
                height: 10,
                width: 10,
                child: RawMaterialButton(
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: profile.onlineMobile ? Colors.green : Colors.red,
                  padding: EdgeInsets.all(1.0),
                  shape: CircleBorder(),
                ),
              ),
            ],
          ),
          // const Text(
          //   'AccessToken: ',
          //   style: TextStyle(fontSize: 20),
          // ),
          // Text(
          //   accessToken.token,
          //   softWrap: true,
          //   style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
          // ),
          // Text('Создан: ${accessToken.created}'),
          // Text('Истекает: ${accessToken.expiresIn}'),
          // if (email != null) Text('Email: $email'),
        ],
      ),
    );
  }

  Future<void> _onPressedLogInButton(BuildContext context) async {
    final res = await widget.plugin.logIn(scope: [
      VKScope.friends,
      VKScope.email,
    ]);

    if (res.isError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Log In failed: ${res.asError.error}'),
        ),
      );
    } else {
      final loginResult = res.asValue.value;
      if (!loginResult.isCanceled) await _updateLoginInfo();
    }
  }

  Future<void> _onPressedLogOutButton() async {
    await widget.plugin.logOut();
    await _updateLoginInfo();
  }

  Future<void> _initSdk() async {
    await widget.plugin.initSdk('7814879');
    _sdkInitialized = true;
    await _updateLoginInfo();
  }

  Future<void> _getSdkVersion() async {
    final sdkVersion = await widget.plugin.sdkVersion;
    setState(() {
      _sdkVersion = sdkVersion;
    });
  }

  Future<void> _updateLoginInfo() async {
    if (!_sdkInitialized) return;

    final plugin = widget.plugin;
    final token = await plugin.accessToken;
    final profileRes = token != null ? await plugin.getUserProfile() : null;
    final email = token != null ? await plugin.getUserEmail() : null;

    setState(() {
      _token = token;
      _profile = profileRes?.asValue?.value;
      _email = email;
      vk = VK(
        token: token.token.toString(),
        language: LanguageType.EN,
      );
    });
  }
}
