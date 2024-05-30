import 'package:coding_challenge/routes.dart';
import 'package:coding_challenge/services/auth_services.dart';
import 'package:coding_challenge/services/listing_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await dotenv.load(fileName: '.env');
  runApp(const FlutterBnB());
}

class FlutterBnB extends StatelessWidget {
  const FlutterBnB({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<ListingService>(
          create: (_) => ListingService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: AuthPage(),
        routes: appRoutes,
      ),
    );
  }
}
