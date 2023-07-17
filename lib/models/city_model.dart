const String cityName = 'name';
const String cityArea = 'area';


class CityModel {
  String name;
  List<String> area;



  CityModel({
    required this.name,
    required this.area,
    });

  Map<String, dynamic> toMap(){
    return <String, dynamic> {
      cityName : name,
      cityArea : area,

    };
  }

  factory CityModel.fromMap(Map<String, dynamic> map){
    return CityModel(
      name: map[cityName],
      area: (map[cityArea] as List).map((e) => e.toString()).toList(),

    );
  }
}