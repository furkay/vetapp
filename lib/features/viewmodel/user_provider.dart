import 'package:flutter/widgets.dart';
import 'package:vetapp/features/model/user.dart';

class UserProvider extends ChangeNotifier{
   UserProvider();
   User _user;
   void setUser(User user){
     _user=user;
     notifyListeners();
   }

   User get getUser=>_user;
}