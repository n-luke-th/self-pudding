import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentSnapshot, Timestamp;

// Data model for a [Pudding] document.
class Pudding {
  final String id;
  final String url;
  final String notes;
  final Timestamp timestamp;

  Pudding({
    required this.id,
    required this.url,
    required this.notes,
    required this.timestamp,
  });

  factory Pudding.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return Pudding(
      id: snapshot.id,
      url: data['url'],
      notes: data['notes'],
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {'url': url, 'notes': notes, 'timestamp': timestamp};
  }

  /// returns the [Pudding] with given values with immutable id
  Pudding copyWith({String? url, String? notes, Timestamp? timestamp}) {
    return Pudding(
      id: id,
      url: url ?? this.url,
      notes: notes ?? this.notes,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
