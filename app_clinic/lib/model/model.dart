
class Clinic{
  late final int id ;
  late final String name;
  late final String phone;
  late final String age;
  late final String problem ;
  late final String date;
  late final String type;
  late final String money;
  late final String rest;
  late final String notes;

  Clinic(
      {
        required this.id,
        required this.name,
        required this.phone,
        required this.age,
        required this.problem,
        required this.date,
        required this.type,
        required this.money,
        required this.rest,
        required this.notes,
      });

  Map<String ,dynamic> toMap(){
    return {
      'id':id,
      'name':name,
      'phone':phone,
      'age':age,
      'problem':problem,
      'date':date,
      'type':type,
      'money':money,
      'rest':rest,
      'notes':notes,
    };
  }

  @override
  String toString() {
    return 'Course {id : $id ,name : $name ,'
        ' phone : $phone , age : $age ,'
        ' problem : $problem, date : $date '
        ', type : $type , money : $money, rest : $rest'
        ', notes : $notes}';
  }


}