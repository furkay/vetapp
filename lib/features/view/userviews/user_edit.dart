import 'package:flutter/material.dart';
import 'package:vetapp/core/service_locator.dart';
import 'package:vetapp/features/service/user_db.dart';
import 'package:vetapp/features/viewmodel/user_provider.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameControl = TextEditingController();
  final TextEditingController _adressControl = TextEditingController();
  final TextEditingController _numberControl = TextEditingController();
  final TextEditingController _passControl = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var user = sl<UserProvider>();
  void initState() {
    _nameControl.text = user.getUser.name;
    _adressControl.text = user.getUser.adress;
    _numberControl.text = user.getUser.number;
    _passControl.text = user.getUser.password;
    super.initState();
  }

  @override
  void dispose() {
    _nameControl.dispose();
    _adressControl.dispose();
    _numberControl.dispose();
    _passControl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar( backgroundColor: Color(0xFF003D78),
        title: Text("Profili Düzenle"),
        centerTitle: true,
       
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image(image: AssetImage("assets/edit.png"),height: 150,),
                ),
                textfieldWidget(_nameControl, "Kullanıcı Adı", Icons.email,
                    false, false, false),
                textfieldWidget(
                    _adressControl, "Adres", Icons.email, true, false, false),
                textfieldWidget(
                    _numberControl, "Numara", Icons.email, true, false, false),
                textfieldWidget(
                    _passControl, "Şifre", Icons.vpn_key, true, false, true),
                    Padding(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: RaisedButton(
              color: Colors.red,
              child: Text(
                "Kaydet",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: validateAndUpdate,
            ),
          ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndUpdate() async {
    if (validateAndSave()) {
      if (_formKey.currentState.validate() == true) {
        // updateValues(userData);

        print("true");
        user.getUser.adress = _adressControl.text;
        user.getUser.number = _numberControl.text;
        user.getUser.password = _passControl.text;
        UserDB()
            .updateUserValues(user.getUser.name,user.getUser)
            .then((value) => _scaffoldKey.currentState.showSnackBar(SnackBar(
                  backgroundColor: Theme.of(context).cardTheme.color,
                  content: Text(
                    "Profil bilgileri güncellendi",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.white),
                  ),
                )));
      }
    }
  }

  Widget textfieldWidget(
      TextEditingController textEditingController,
      String label,
      IconData iconData,
      bool isEnable,
      bool isSuffix,
      bool obscure) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0xFF003D78),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: TextFormField(
        enabled: isEnable,
        controller: textEditingController,
        minLines: 1,
        obscureText: obscure,
        validator: (value) {
          if (value.isEmpty) {
            return 'Boş bırakılamaz';
          }
          return null;
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          filled: true,
          fillColor: Colors.grey.shade50.withAlpha(10),
          border: InputBorder.none,
          icon: Icon(iconData, color: Colors.white),
        ),
      ),
    );
  }
}
