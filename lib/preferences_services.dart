import 'package:progetto/models.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PreferencesService{


  Future saveAccount(Account account) async{
    final ac= await SharedPreferences.getInstance();

    await ac.setString('userName', account.username);
    await ac.setString('emailAddress', account.emailaddress);
    await ac.setString('birthDay', account.birthday);

  }

  Future<Account> getAccount() async{
    final ac= await SharedPreferences.getInstance();

    final username =  ac.getString('userName');
    final emailaddress = ac.getString('emailAddress');
    final birthday =  ac.getString('birthDay');

    return Account(username: username!, emailaddress: emailaddress!, birthday: birthday!);

   
  }
}