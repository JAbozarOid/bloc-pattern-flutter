class Category {

  static const NAME_KEY = 'name';
  String id;
  String name;

  // this constructor return the name and initial the value for name
  Category(){
    name = 'motherboard';
  }

  // create constructor from firebase
  Category.fromFirestore(Map<String,dynamic> json){
    name = json[NAME_KEY];
  }



}