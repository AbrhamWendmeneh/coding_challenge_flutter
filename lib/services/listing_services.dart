import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_challenge/models/listing.dart';

class ListingService {
  final CollectionReference _listingCollection =
      FirebaseFirestore.instance.collection('listings');

  Future<Listing> createListing(
      String title, String description, double price) async {
    String id = _listingCollection.doc().id;
    Listing newListing =
        Listing(id: id, title: title, description: description, price: price);
    await _listingCollection.doc(id).set(newListing.toFirestore());
    return Listing(
        id: id, title: title, description: description, price: price);
  }

  Future<List<Listing>> browseListings() async {
    QuerySnapshot querySnapshot = await _listingCollection.get();
    return querySnapshot.docs
        .map((doc) => Listing.fromFirestore(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Stream<List<Listing>> browseListingsStream() {
    return Stream.fromFuture(browseListings());
  }
}
