class ProfileQuery {
  List<Docss> docs;
  String bookmark;

  ProfileQuery({this.docs, this.bookmark});

  ProfileQuery.fromJson(Map<String, dynamic> json) {
    //if (json['docs'] != null) {
    if (json['docs'].length != 0) {
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
  String userlocation;
  List<String> topics;
  List<String> workgroup;
  List<String> hubLocation;

  Preferences({this.userlocation, this.topics, this.workgroup, this.hubLocation});

  Preferences.fromJson(Map<String, dynamic> json) {
    userlocation = json['userlocation'];
    topics = json['topics'].cast<String>();
    workgroup = json['workgroup'].cast<String>();
    hubLocation = json['hubLocation'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userlocation'] = this.userlocation;
    data['topics'] = this.topics;
    data['workgroup'] = this.workgroup;
    data['hubLocation'] = this.hubLocation;
    return data;
  }
}
