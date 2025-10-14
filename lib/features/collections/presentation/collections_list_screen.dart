import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pudding/common/components/btns.dart';
import 'package:pudding/common/components/full_page_loading.dart';
import 'package:pudding/common/components/loading_overlay.dart';
import 'package:pudding/common/components/view_wrappers.dart';
import 'package:pudding/core/models/appbar_cfg_model.dart';
import 'package:pudding/core/navigation/routing.dart';

import 'package:pudding/features/auth/providers/auth_providers.dart';
import 'package:pudding/features/collections/presentation/new_collection_form_panel.dart';
import 'package:pudding/features/collections/providers/collections_providers.dart';

// A ConsumerWidget can listen to providers.
// TODO: add visibility selection
class CollectionsListScreen extends ConsumerWidget {
  // final StreamProvider<List<TheCollection>> streamProvider;
  const CollectionsListScreen({super.key});

  Future<void> handleSignOut(WidgetRef ref) async {
    LoadingOverlay.showDefaultLoading(msg: "Logging out");
    await ref.read(authRepositoryProvider).signOut();
    LoadingOverlay.dismissLoading();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionsAsyncValue = ref.watch(collectionsStreamProviderAsOwner);

    return pageViewWrapper(
      appBarCfg: AppbarCfgModel(
        leading: IconButton.outlined(
          onPressed: () async => await handleSignOut(ref),

          icon: const Icon(Icons.logout_outlined),
        ),
        titleStr: 'Collections',
        animateColor: true,
      ),
      body: collectionsAsyncValue.when(
        // The .when() method is perfect for handling loading/error states.
        data: (collections) => ListView.builder(
          itemCount: collections.length,
          itemBuilder: (context, index) {
            final collection = collections[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: ListTile(
                title: Text(collection.title),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  // Navigate to the screen for this specific collection.
                  Routing.pushToPuddingsScreen(collection: collection);
                },
              ),
            );
          },
        ),
        loading: () => FullPageLoading.df,
        error: (err, stack) =>
            errorPageWrapper(errorValue: "loading collections error: $err"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: filledTextIconBtn(
        onPressed: () => _addCollectionDialog(context, ref),
        // TODO: localize
        text: Text("NEW COLLECTION"),
        icon: const Icon(LucideIcons.folderPlus),
      ),
    );
  }

  void _addCollectionDialog(BuildContext context, WidgetRef ref) async {
    final userId = ref.read(userIdProvider);
    if (userId != null) {
      final Timestamp now = Timestamp.now();
      ref
          .read(collectionDraftProvider.notifier)
          .createDraft(now: now, uid: userId);
    }
    await SmartDialog.show(
      builder: (_) {
        return const NewCollectionFormPanel();
      },
      keepSingle: true,
      alignment: Alignment.bottomCenter,
      usePenetrate: true,
      clickMaskDismiss: false,
    );
  }
}
