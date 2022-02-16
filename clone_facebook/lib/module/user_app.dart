enum Status {
  singel,
  dating,
  research,
  engaged,
  married,
  widow,
  complicated,
  unknown,
}

class UserApp {
  final String id;
  String? name;
  final String email;
  List? friends;
  String? bio;
  String? avatar;
  String? backgruond;
  final String numberPhone;
  Status? status;
  String? living;
  String? from;
  final DateTime isActive;

  set setName(String _name) => name = _name;

  set setBio(String _bio) => bio = _bio;

  set setAvatar(String _avatar) => avatar = _avatar;

  set setBackgruond(String _background) => backgruond = _background;

  set setStatus(Status _status) => status = _status;

  set setLiving(String _living) => living = _living;

  set setFrom(String _from) => from = _from;

  UserApp({
    required this.id,
    required this.name,
    required this.email,
    required this.friends,
    required this.bio,
    required this.avatar,
    required this.backgruond,
    required this.numberPhone,
    required this.status,
    required this.living,
    required this.from,
    required this.isActive,
  });

  factory UserApp.fromJson(Map<String, dynamic> json) {
    Status _status;
    switch (json['status']) {
      case 'singel':
        _status = Status.singel;
        break;
      case 'dating':
        _status = Status.dating;
        break;
      case 'research':
        _status = Status.research;
        break;
      case 'engaged':
        _status = Status.engaged;
        break;
      case "married":
        _status = Status.married;
        break;
      case "widow":
        _status = Status.widow;
        break;
      case "complicated":
        _status = Status.complicated;
        break;
      default:
        _status = Status.unknown;
    }

    return UserApp(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      friends: json['friends'],
      bio: json['bio'],
      avatar: json['avatar'],
      backgruond: json['backgruond'],
      numberPhone: json['numberPhone'],
      status: _status,
      living: json['living'],
      from: json['from'],
      isActive: json['isActive'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    String _status;

    switch (status) {
      case Status.singel:
        _status = "singel";
        break;
      case Status.dating:
        _status = "dating";
        break;
      case Status.research:
        _status = "research";
        break;
      case Status.engaged:
        _status = "engaged";
        break;
      case Status.married:
        _status = "married";
        break;
      case Status.widow:
        _status = "widow";
        break;
      case Status.complicated:
        _status = "complicated";
        break;
      default:
        _status = 'unknown';
    }

    return {
      'id': id,
      'name': name,
      'email': email,
      'friends': friends,
      'bio': bio,
      'avatar': avatar,
      'backgruond': backgruond,
      'numberPhone': numberPhone,
      'status': _status,
      'living': living,
      'from': from,
      'isActive': isActive,
    };
  }
}
