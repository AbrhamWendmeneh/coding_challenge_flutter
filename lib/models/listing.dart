class Listing {
  final String id;
  final String title;
  final String description;
  final double price;

  Listing({required this.id, required this.title, required this.description, required this.price});

  // Add a method to convert Firestore document to Listing object
  factory Listing.fromFirestore(Map<String, dynamic> data) {
    return Listing(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      price: data['price'],
    );
  }

  // Add a method to convert Listing object to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
    };
  }
}
