import 'package:flutter/material.dart';
//importaciones de firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//servicios
import 'package:flutter_crud_firebase/services/firebase_service.dart';

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
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Material App Bar')),
      body: FutureBuilder(
        future: getPeople(),
        //snapshot es el resultado de lo que nos devuelva getPeople()
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                //name se llama la propiedad que tenemnos en nuestro fire store
                return Text(snapshot.data?[index]['name']);
              },
            );
          }else{
            return const Center(
              child: Text("Cargando ... "),
            );
          }
        }),
      ),
    );
  }
}
