import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/services/firebase_service.dart';

class AdicionarNombresPage extends StatefulWidget {
  const AdicionarNombresPage({super.key});

  @override
  State<AdicionarNombresPage> createState() => _AdicionarNombresPageState();
}

class _AdicionarNombresPageState extends State<AdicionarNombresPage> {
  TextEditingController nameController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar nombre')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          spacing: 10,
          children: [
            TextField(
              //lo que nosotros escribamos en nuestro campo automaticamente se guardara en nuestro controller
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Ingrese el nombre'),
            ),
            ElevatedButton(
              onPressed: () async {
                await addPeople(nameController.text).then((_) {
                  //lo que esta dentro del then se ejecutara cuando el future termine
                  if(!context.mounted) return;
                  Navigator.pop(context);
                });
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
