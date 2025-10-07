// aca haremos todas las funciones que tengan que ver con la administracion en firebase
import 'package:cloud_firestore/cloud_firestore.dart';

//crearemos una instancia de nuestra base de datos con FireStore
FirebaseFirestore db = FirebaseFirestore.instance;
//crearemos una funcion para poder ver los datos que creamos en nuestra firestore
//como sera una consulta a la base de datos este tiene que ser un FUTURE
Future<List> getPeople() async{
  List people = [];
  //crearemos una referencia ami coleccion de firestore
  //el nombre que esta dentro de db.collection() debe concidir con el nombre de nuestra base de datos en firestore
  CollectionReference collecionReferencePeople = db.collection('people');
  //ahora haremos nuestro query
  // con el collecionReferencePeople.get(); nos traera todos los valores que estan en nuestra tabla people
  // se debe tener cuidado con este get ya que este me trae todos los datos de people de mi fire store
  QuerySnapshot queryPeople = await collecionReferencePeople.get();
  // queryPeople.docs.forEach((documento){
  //   // en cada iteracion es un documento diferente
  //   //para cada documento lo agregare a mi people
  //   people.add(documento.data());
  // });
  for (var documento in queryPeople.docs) {
    final Map<String, dynamic> data = documento.data() as Map<String,dynamic>;
    final person = {
      'uid' : documento.id,
      'name' : data['name'],
    };
    // en cada iteracion es un documento diferente
    //para cada documento lo agregare a mi people
    //people.add(documento.data());
    people.add(person);
  }
  return people;
}
//metodo que nos ayuda a guardar datos desde la aplicacion a nuestra fire store
Future<void> addPeople(String name) async{
  //esperaremos a que nuestra base de datos guarde nuestra collecion
  //al colocarle people hacemos referencia a nuestra people que nos creamos en fire store
  //en add le tenemos que añadir el objeto creado en nuestra base de datos de fire store
  await db.collection('people').add({"name" : name});
}

//este sera el metodo de actualizar o editar en el firestore
Future<void> updatePeople(String uid,String newName) async{
  //con el .doc le decimos que documento yo quiero modificar
  //luego con el set le decimos que actualizaremos el name que sera el nuevo name
  await db.collection('people').doc(uid).set({'name':newName});
}
Future<void> deletePeople(String uid) async{
  await db.collection('people').doc(uid).delete();
}