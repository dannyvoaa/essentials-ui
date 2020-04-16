class ProfileQuery {
  List<Docss> docs;
  String bookmark;

  ProfileQuery({this.docs, this.bookmark});

  ProfileQuery.fromJson(Map<String, dynamic> json) {
    if (json['docs'] != null) {
      docs = new List<Docss>();
      json['docs'].forEach((v) {
        docs.add(new Docss.fromJson(v));
      });
    }
    bookmark = json['bookmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.docs != null) {
      data['docs'] = this.docs.map((v) => v.toJson()).toList();
    }
    data['bookmark'] = this.bookmark;
    return data;
  }
}

class Docss {
  Preferences preferences;

  Docss({this.preferences});

  Docss.fromJson(Map<String, dynamic> json) {
    preferences = json['preferences'] != null
        ? new Preferences.fromJson(json['preferences'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.preferences != null) {
      data['preferences'] = this.preferences.toJson();
    }
    return data;
  }
}

class Preferences {
  String location;
  List<String> topics;
  List<String> workgroup;

  Preferences({this.location, this.topics, this.workgroup});

  Preferences.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    topics = json['topics'].cast<String>();
    workgroup = json['workgroup'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = this.location;
    data['topics'] = this.topics;
    data['workgroup'] = this.workgroup;
    return data;
  }
}
