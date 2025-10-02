import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pudding/core/logger/logger_providers.dart' show logger;
import 'package:pudding/features/puddings/data/pudding_model.dart';
import 'package:pudding/features/puddings/providers/puddings_providers.dart';

class PuddingsScreen extends ConsumerWidget {
  final String collectionId;
  final String collectionTitle;

  const PuddingsScreen({
    super.key,
    required this.collectionId,
    required this.collectionTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // We watch the provider ".family" and pass in the collectionId.
    // Riverpod will create a separate provider for each unique collectionId.
    final puddingsAsyncValue = ref.watch(puddingsStreamProvider(collectionId));

    return Scaffold(
      appBar: AppBar(title: Text(collectionTitle)),
      body: puddingsAsyncValue.when(
        data: (p) => ListView.builder(
          itemCount: p.length,
          itemBuilder: (context, index) {
            final pudding = p[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: ListTile(
                title: Text(pudding.notes, overflow: TextOverflow.ellipsis),
                subtitle: Text(pudding.url, overflow: TextOverflow.ellipsis),
                isThreeLine: true,
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addPuddingDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addPuddingDialog(BuildContext context, WidgetRef ref) {
    final urlController = TextEditingController();
    final notesController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Pudding'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: urlController,
              decoration: const InputDecoration(labelText: 'URL'),
            ),
            TextField(
              controller: notesController,
              decoration: const InputDecoration(labelText: 'Notes'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (urlController.text.isNotEmpty) {
                final newPudding = Pudding(
                  id: '',
                  url: urlController.text,
                  notes: notesController.text,
                  timestamp: Timestamp.now(),
                );
                // Call the addPudding method from the repository provider.
                ref
                    .read(puddingsRepositoryProvider)
                    .addPudding(collectionId, newPudding);
                Navigator.of(context).pop();
                logger.info("new pudding added");
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
