import 'package:intl/intl.dart';

class FormatterUtil{
  static String getFormattedPrice(num price) {
    final formatter = new NumberFormat("0.00");
    return "RM ${formatter.format(price)}";
  }

  static String upperFirstCharacter(String string){
    return "${string[0].toUpperCase()}${string.substring(1).toLowerCase()}";
  }

  static String getDateStringFromMilliseconds(int timestamp){
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat("dd/MM/yyyy @ hh:mm:s a").format(dateTime);
  }
}