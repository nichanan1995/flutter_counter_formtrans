class JsonModel {
  // Create Field
  int id;
  String licen, trans, name;

//   // Constructor
//   JsonModel(
//       int idInt, String nameString, String userString, String passwordString) {
// //     id=idInt;
// // name =nameString;
// // user =userString;
// // password = passwordString;
//   }

  JsonModel(this.id, this.licen, this.trans, this.name);

JsonModel.fromJson(Map<String, dynamic> parseJSON){
  id = int.parse(parseJSON['id']);
  licen = parseJSON['Licen'];
  trans = parseJSON['Trans'];
  name = parseJSON['Name'];
  
}
}