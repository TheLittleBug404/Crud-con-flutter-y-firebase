import 'package:flutter/material.dart';
import 'package:flutter_crud_firebase/services/firebase_service.dart';

class EditarNombrePage extends StatefulWidget {
  const EditarNombrePage({super.key});

  @override
  State<EditarNombrePage> createState() => _EditarNombrePageState();
}

class _EditarNombrePageState extends State<EditarNombrePage> {
  TextEditingController editarNameController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    //aca haremos una variable de tipo mapa para que nuestro text controller este con el nombre presionado
    //en arguments esta el name que pasamos de home_page
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    editarNameController.text = arguments['name'];
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Nombre')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          spacing: 10,
          children: [
            TextField(
              controller: editarNameController,
              decoration: const InputDecoration(hintText: 'Cambiar el nombre'),
            ),
            ElevatedButton(
              onPressed: () async {
                await updatePeople(arguments['uid'], editarNameController.text);
                if(!context.mounted) return;
                Navigator.pop(context);
              },
              child: const Text('Editar'),
            ),
          ],
        ),
      ),
    );
  }
}
