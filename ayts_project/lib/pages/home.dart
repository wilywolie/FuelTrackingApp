import 'package:ayts_project/services/auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService _authService = AuthService();
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => AddStatusPage()));  //homepage degiscek addstatuspage ile
      //   },
      //   child: Icon(Icons.add),
      // ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text("Ahmet Akdemir"),
              accountEmail: Text("ahmet.akdemir@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("assets/images/beyaz.png"),
              ),
            ),
            ListTile(
              title: const Text('Anasayfa'),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Profilim'),
              onTap: () {
                Navigator.pop(context);
              },
              leading: const Icon(Icons.person),
            ),
            const Divider(),
            ListTile(
              title: const Text('Hesabimi Sil'),
              onTap: () async {
                await _authService.deleteUser().then((value) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
              leading: const Icon(Icons.remove_circle_outline),
            ),
            ListTile(
              title: const Text('Çıkış yap'),
              onTap: () async {
                await _authService.signOut().then((value) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              },
              leading: const Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
      )),
    );
  }
}
