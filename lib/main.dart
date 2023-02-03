import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forum/feature/authentication/screens/authentication_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:forum/viewmodels/auth_viewmodel.dart';
import 'package:forum/viewmodels/global_ui_viewmodel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'feature/authentication/screens/login_screen.dart';
import 'feature/authentication/screens/register_screen.dart';
import 'feature/authentication/widgets/splash_screen.dart';
import 'feature/dashboard/screens/dashboard_screen.dart';

// void main() {
//   runApp(const AuthenticationScreen());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(const AuthenticationScreen());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Forum - Chat Application',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.cyan,
//         textTheme: GoogleFonts.latoTextTheme(),
//       ),
//       home: const AuthenticationScreen(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalUIViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: GlobalLoaderOverlay(
        useDefaultLoading: true,
        child: Consumer<GlobalUIViewModel>(builder: (context, loader, child) {
          if (loader.isLoading) {
            context.loaderOverlay.show();
          } else {
            context.loaderOverlay.hide();
          }
          return MaterialApp(
            title: 'Forum - Chat Application',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.cyan,
              textTheme: GoogleFonts.latoTextTheme(),
            ),
            initialRoute: "/splash",
            routes: <String, WidgetBuilder>{
              "/splash": (BuildContext context) => SplashScreen(),
              "/authentication": (BuildContext context) =>
                  const AuthenticationScreen(),
              "/login": (BuildContext context) => const LoginScreens(),
              "/register": (BuildContext context) => const RegisterScreen(),
              "/dashboard": (BuildContext context) => const DashboardScreen(),
            },
          );
        }),
      ),
      // home: const AuthenticationScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
