import 'package:flutter/material.dart';
//importaciones de firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_crud_firebase/pages/adicionar_nombres_page.dart';
import 'package:flutter_crud_firebase/pages/editar_nombre_page.dart';
import 'package:flutter_crud_firebase/pages/home_page.dart';
import 'firebase_options.dart';

void main() async {
  //en esta parte inicializaremos nuestro servidor a firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/add' : (context) => const AdicionarNombresPage(),
        '/editar' : (context) => const EditarNombrePage()
      },
    );
  }
}


