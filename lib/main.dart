import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reuse_app/Login_Screen.dart';
import 'package:reuse_app/add_item1.dart';
import 'package:reuse_app/add_item2.dart';
import 'package:reuse_app/item_notifier.dart';
import 'package:reuse_app/myaccount.dart';
import 'package:reuse_app/upload_images.dart';
import 'Home_Screen.dart';
import 'RegistrationScreen.dart';
import 'donatedItem.dart';
import 'item.dart';
import 'package:firebase_core/firebase_core.dart';

import 'auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(ReuseApp());
}

class ReuseApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) {
            return AuthProvider();
          },
        ),
        ChangeNotifierProvider<ItemNotifier>(
          create: (_) {
            return ItemNotifier();
          },
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: HomeScreen.id,
          routes: {
            LoginScreen.id: (context) => LoginScreen(),
            RegistrationScreen.id: (context) => RegistrationScreen(),
            AddItem1.id: (context) => AddItem1(),
            AddItem.id: (context) => AddItem(),
            DonatedItem.id:(context) => DonatedItem(),
            UploadImages.id: (context) => UploadImages(),
            HomeScreen.id: (context) => HomeScreen(),
            Myaccount.id: (context) => Myaccount(),
            Item.id: (context) => Item(),
          }),
    );
  }
}
