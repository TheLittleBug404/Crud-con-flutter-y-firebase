import 'dart:developer';

import 'package:flutter/material.dart';
//servicio de firebase
import 'package:flutter_crud_firebase/services/firebase_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CRUD con FIREBASE')),
      body: FutureBuilder(
        future: getPeople(),
        //snapshot es el resultado de lo que nos devuelva getPeople()
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(
                right: 10,
                left: 10,
                top: 10,
                bottom: 100,
              ),
              child: ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  //name se llama la propiedad que tenemnos en nuestro fire store
                  return ListTile(
                    title: Text(snapshot.data?[index]['name']),
                    trailing: SizedBox(
                      width: 110,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              await Navigator.pushNamed(
                                context,
                                '/editar',
                                arguments: {
                                  'name': snapshot.data?[index]['name'],
                                  'uid': snapshot.data?[index]['uid'],
                                },
                              );
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.amber.shade600,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.blueGrey.shade100,
                                    title: Text(
                                      'Esta seguro de eliminar a ${snapshot.data?[index]['name']}',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          log('presionaste confirmar');
                                          await deletePeople(snapshot.data?[index]['uid']).then((_){
                                            if(!context.mounted) return;
                                            Navigator.pop(context);
                                          });
                                          setState(() {});
                                        },
                                        child: const Text('Confirmar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text('Cancelar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text("Cargando ... "));
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //navegacion a la pagina de agregar pantalla
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
