class Cast {
  List<Actor> actores = new List();
  Cast.fromJsonList(List<dynamic> jsonList) {
    if(jsonList == null) {
      return;
    }

    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    castId = json['cast_id'];
    character = json['character'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    order = json['order'];
    profilePath = json['profile_path'];
  }

  getFoto() {
    if(profilePath == null) {
      return 'https://image.shutterstock.com/image-vector/no-image-available-sign-absence-260nw-373243873.jpg';
    }
    return 'https://image.tmdb.org/t/p/w154/$profilePath';
  }
}