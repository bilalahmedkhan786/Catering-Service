class Daig {
  String id;
  String name;
  int quantity;
  String status;

  Daig({
    required this.id,
    required this.name,
    required this.quantity,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'status': status,
    };
  }

  factory Daig.fromMap(Map<String, dynamic> map) {
    return Daig(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      status: map['status'] ?? 'Pending',
    );
  }
}
