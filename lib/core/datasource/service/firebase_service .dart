import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // =========================
  // Save Favorite
  // =========================

  Future<void> saveFavorite({
    required String userId,
    required int productId,
    required bool isFavorite,
  }) async {
    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .doc(productId.toString());

    if (isFavorite) {
      await docRef.set({'isFavorite': true});
    } else {
      await docRef.delete();
    }
  }

  // =========================
  // Save Cart
  // =========================

  Future<void> saveCart({
    required String userId,
    required int productId,
    required bool shoppingCart,
  }) async {
    final docRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .doc(productId.toString());

    if (shoppingCart) {
      await docRef.set({'shoppingCart': true});
    } else {
      await docRef.delete();
    }
  }

  // =========================
  // Get Favorites
  // =========================

  Future<List<int>> getFavorites(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .get();

    return snapshot.docs
        .map((doc) => int.parse(doc.id))
        .toList();
  }

  // =========================
  // Get Cart
  // =========================

  Future<List<int>> getCart(String userId) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('cart')
        .get();

    return snapshot.docs
        .map((doc) => int.parse(doc.id))
        .toList();
  }
}