import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentSnapshot, Timestamp;

// Data model for [TheCollection] document.
class TheCollection {
  final String id;
  final String title;
  final String ownerId;
  final List<String> collaborators;
  // final List<Map<String, Timestamp>> editLogs;
  final List<String> tags;

  TheCollection({
    required this.id,
    required this.title,
    required this.ownerId,
    required this.collaborators,
    // required this.editLogs,
    required this.tags,
  });

  factory TheCollection.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return TheCollection(
      id: snapshot.id, // Get the document ID
      title: data['title'],
      ownerId: data['ownerId'],
      collaborators: List<String>.from(data['collaborators']),
      // editLogs: List<Map<String, Timestamp>>.from( data['editLogs'] ).where((it)=> it.),
      tags: List<String>.from(data['tags']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'ownerId': ownerId,
      'collaborators': collaborators,
      //'editLogs': editLogs,
      'tags': tags,
    };
  }

  /// returns the [TheCollection] with given values with immutable id
  TheCollection copyWith({
    String? title,
    String? ownerId,
    List<String>? collaborators,
    List<Map<String, Timestamp>>? editLogs,
    List<String>? tags,
  }) {
    return TheCollection(
      id: id,
      title: title ?? this.title,
      ownerId: ownerId ?? this.ownerId,
      collaborators: collaborators ?? this.collaborators,
      //editLogs: editLogs ?? this.editLogs,
      tags: tags ?? this.tags,
    );
  }
}
