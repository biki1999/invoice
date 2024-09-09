class Medicine {
  final int serialNo;
  final String name;
  final int quantity;
  final double unit;
  final double price;
  final double gst;
  final double discount;
  final double totalPrice;

  Medicine({
    required this.serialNo,
    required this.name,
    required this.quantity,
    required this.unit,
    required this.price,
    required this.gst,
    required this.discount,
    required this.totalPrice,
  });
}
