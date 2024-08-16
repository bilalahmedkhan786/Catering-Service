class Daig {
  String id;
  String name;
  int quantity;
  String status;
  String allocatedTo;
  DateTime dateAllocated;

  Daig({
    required this.id,
    required this.name,
    required this.quantity,
    required this.status,
    required this.allocatedTo,
    required this.dateAllocated,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'status': status,
      'allocatedTo': allocatedTo,
      'dateAllocated': dateAllocated.toIso8601String(),
    };
  }

  factory Daig.fromMap(Map<String, dynamic> map) {
    return Daig(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 0,
      status: map['status'] ?? 'Pending',
      allocatedTo: map['allocatedTo'] ?? 'Unassigned',
      dateAllocated: DateTime.parse(
          map['dateAllocated'] ?? DateTime.now().toIso8601String()),
    );
  }
}
