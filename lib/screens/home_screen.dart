import 'package:coding_challenge/models/listing.dart';
import 'package:coding_challenge/services/auth_services.dart';
import 'package:coding_challenge/services/listing_services.dart';
import 'package:coding_challenge/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  List<Listing> listings = [];

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<AuthService>(context).currentUser();
    final listingService = Provider.of<ListingService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterBnB'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Provider.of<AuthService>(context, listen: false).signOut();
              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _priceController,
                      decoration: const InputDecoration(
                        labelText: 'Price',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kColorBlue,
                    ),
                    onPressed: () async {
                      Listing newListing = await listingService.createListing(
                        _titleController.text,
                        _descriptionController.text,
                        double.parse(_priceController.text),
                      );

                      setState(() {
                        listings.add(newListing);
                      });

                      // Clear the text fields
                      _titleController.clear();
                      _descriptionController.clear();
                      _priceController.clear();
                    },
                    child: const Text(
                      'Create Listing',
                      style: TextStyle(
                        color: kColorWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/map');
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View on Map',
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Icon(Icons.map),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 200,
              child: StreamBuilder<List<Listing>>(
                stream: listingService.browseListingsStream(),
                builder: (context, snapshot) {
                  // use the snapshot data if it's available, otherwise use local list
                  List<Listing> listings = snapshot.data ?? this.listings;

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return ListView.separated(
                      itemCount: listings.length,
                      separatorBuilder: (context, index) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(color: kColorGreyShade400),
                      ),
                      itemBuilder: (context, index) {
                        final listing = listings[index];
                        return ListTile(
                          title: Text(listing.title),
                          subtitle: Text(listing.description),
                          trailing:
                              Text('\$${listing.price.toStringAsFixed(2)}'),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
