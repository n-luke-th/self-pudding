import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pudding/common/components/btns.dart'
    show editableModeIconBtnSwitch;
import 'package:pudding/common/components/view_wrappers.dart';
import 'package:pudding/common/parts.dart';
import 'package:pudding/core/logger/logger_providers.dart';
import 'package:pudding/core/models/appbar_cfg_model.dart';
import 'package:pudding/features/collections/providers/collections_providers.dart'
    show collectionDraftProvider;

class CollectionDraftScreen extends ConsumerStatefulWidget {
  const CollectionDraftScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CollectionDraftScreenState();
}

class _CollectionDraftScreenState extends ConsumerState<CollectionDraftScreen> {
  final TextEditingController titleCtl = TextEditingController();
  final TextEditingController descriptionCtl = TextEditingController();
  bool isEditable = true;

  @override
  void initState() {
    final String? initialTitleTxt = ref
        .read(collectionDraftProvider.notifier)
        .obj
        ?.title;
    final String? initialDescTxt = ref
        .read(collectionDraftProvider.notifier)
        .obj
        ?.description;
    if (initialTitleTxt != null) {
      titleCtl.text = initialTitleTxt;
    }
    if (initialDescTxt != null) {
      descriptionCtl.text = initialDescTxt;
    }

    super.initState();
    logger.debug("title txt: $initialTitleTxt");
  }

  @override
  Widget build(BuildContext context) {
    return pageViewWrapper(
      appBarCfg:
          // TODO: localize
          AppbarCfgModel(
            titleStr: "Collection Draft",
            overrideActions: [
              Padding(
                padding: Parts.smallEdgeInsetsAll,
                child: editableModeIconBtnSwitch(
                  look: 2,
                  size: 24,
                  onPressed: () {
                    setState(() {
                      isEditable = !isEditable;
                    });
                  },
                  isSelected: isEditable,
                ),
              ),
            ],
          ),
      body: Padding(
        padding: Parts.defaultEdgeInsetsAll,
        child: Center(
          child: Form(
            child: Wrap(
              children: [
                TextFormField(readOnly: !isEditable, controller: titleCtl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
