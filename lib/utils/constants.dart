const String currencysymbol = '৳';


abstract class PaymentMethod{     //cls gulate jate kew object create korte na pare ta abstract kore dici
  static const String cod = 'Cash on Delivery';
  static const String online = 'Online Payment';
}

abstract class OrderStatus{
  static const String pending = 'Pending';
  static const String processing = 'Processing';
  static const String delivered = 'Delivered';
  static const String cancelled = 'Cancelled';
}

enum OrderFilter{
  TODAY,YESTERDAY,SEVER_DAYS, THIS_MONTH,ALL_TIME;
}