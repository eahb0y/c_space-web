import 'package:intl/intl.dart' as intl;
class Functions{
  static String moneyFormatNoSum(num number) {
    String splitter = " ";
    final isNegative = number.isNegative;
    number = number.abs();
    String result = "0";
    result = intl.NumberFormat("#,##0", "ru_RU")
        .format(number)
        .split(",")
        .join(splitter);
    return isNegative ? "-$result" : result;
  }
}