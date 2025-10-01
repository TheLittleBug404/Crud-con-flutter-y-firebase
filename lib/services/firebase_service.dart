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
    // en cada iteracion es un documento diferente
    //para cada documento lo agregare a mi people
    people.add(documento.data());
  }
  return people;
}