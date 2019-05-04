import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  searchByName(String searchField) {
    return Firestore.instance
        .collection('mostviewed')
        .where('name',
        isGreaterThanOrEqualTo: searchField.toUpperCase())
        .getDocuments();
  }
}