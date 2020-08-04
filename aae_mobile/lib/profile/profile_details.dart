import 'package:inject/inject.dart';

class ProfileDetails {

  String userfullname;
  String useremail;
  String userlocation;

  static ProfileDetails single_instance = null;

  static ProfileDetails getInstance()
  {
    if (single_instance == null)
      single_instance = new ProfileDetails();

    return single_instance;
  }

  setFullname(String fullname) {
    this.userfullname = fullname;
  }

  setEmail(String email) {
    this.useremail = email;
  }

  setLocation(String location) {
    this.userlocation = location;
  }

  @provide
  @singleton
  ProfileDetails();



}