import 'package:coding_challenge/services/listing_services.dart';
import 'package:flutter/material.dart';
import 'package:coding_challenge/models/listing.dart';

class ListingAccommodationsScreen extends StatefulWidget {
  @override
  _ListingAccommodationsScreenState createState() =>
      _ListingAccommodationsScreenState();
}

class _ListingAccommodationsScreenState
    extends State<ListingAccommodationsScreen> {
  final ListingService _listingService = ListingService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing Accommodations'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
            ),
          ),
          ElevatedButton(
            child: const Text('Create Listing'),
            onPressed: () async {
              await _listingService.createListing(
                _titleController.text,
                _descriptionController.text,
                double.parse(_priceController.text),
              );
              setState(() {});
            },
          ),
          Expanded(
            child: FutureBuilder<List<Listing>>(
              future: _listingService.browseListings(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      Listing listing = snapshot.data![index];
                      return ListTile(
                        title: Text(listing.title),
                        subtitle: Text(listing.description),
                        trailing: Text('\$${listing.price.toStringAsFixed(2)}'),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
