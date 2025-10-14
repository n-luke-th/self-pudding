import 'package:cloud_firestore/cloud_firestore.dart'
    show DocumentSnapshot, Timestamp;
import 'package:pudding/features/collections/data/visibility_enum.dart';

/// Data model for [TheCollection] document.
class TheCollection {
  final String id;
  final String title;
  final String description;
  final String ownerId;
  final Timestamp createdAt;
  final Timestamp lastUpdatedAt;
  final VisibilityEnum visibility;
  final List<String> tags;

  TheCollection({
    required this.id,
    required this.title,
    this.description = "",
    required this.ownerId,
    required this.createdAt,
    required this.lastUpdatedAt,
    required this.visibility,
    required this.tags,
  });

  @override
  String toString() {
    super.toString();
    return "TheCollection: ${toFirestore().toString()}";
  }

  factory TheCollection.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data()!;
    return TheCollection(
      id: snapshot.id, // Get the document ID
      title: data['title'],
      description: data['description'],
      ownerId: data['ownerId'],
      createdAt: data['createdAt'] as Timestamp,
      lastUpdatedAt: data['lastUpdatedAt'] as Timestamp,
      visibility: VisibilityEnum.getEnum(data['visibility'].toString()),
      tags: List<String>.from(data['tags']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'ownerId': ownerId,
      'createdAt': createdAt,
      'lastUpdatedAt': lastUpdatedAt,
      'visibility': visibility.name,
      'tags': tags,
    };
  }

  /// returns the [TheCollection] with given values with immutable id
  TheCollection copyWith({
    String? title,
    String? description,
    String? ownerId,
    Timestamp? createdAt,
    Timestamp? lastUpdatedAt,
    VisibilityEnum? visibility,
    List<String>? tags,
  }) {
    return TheCollection(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      visibility: visibility ?? this.visibility,
      tags: tags ?? this.tags,
    );
  }
}
