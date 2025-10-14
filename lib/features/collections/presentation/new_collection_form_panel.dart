import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pudding/common/components/btns.dart'
    show filledTextIconBtn, secondaryTextIconBtn;
import 'package:pudding/common/components/view_wrappers.dart'
    show layoutBuilder;
import 'package:pudding/common/parts.dart' show Parts, SizingScale;
import 'package:pudding/core/navigation/routing.dart';
import 'package:pudding/core/logger/logger_providers.dart';
import 'package:pudding/features/collections/providers/collections_providers.dart';
import 'package:validatorless/validatorless.dart';

class NewCollectionFormPanel extends ConsumerStatefulWidget {
  const NewCollectionFormPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewCollectionFormPanelState();
}

class _NewCollectionFormPanelState
    extends ConsumerState<NewCollectionFormPanel> {
  final descFocus = FocusNode(debugLabel: 'collectionDescField');
  final TextEditingController titleCtl = TextEditingController();
  final TextEditingController descriptionCtl = TextEditingController();

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
  }

  void updateFormData() {
    final now = Timestamp.now();
    return ref
        .read(collectionDraftProvider.notifier)
        .updateImportantProps(
          sameCreateUpdateTime: true,
          now: now,
          newDes: descriptionCtl.text.trim(),
          newTitle: titleCtl.text.trim(),
        );
  }

  Widget renderPanel(
    BuildContext ctx,
    WidgetRef ref, {
    double widthFactor = 0.7,
    double heightFactor = 0.6,
  }) {
    return Padding(
      padding: Parts.bigEdgeInsetsAll,
      child: Container(
        height: MediaQuery.sizeOf(ctx).height * heightFactor,
        width: MediaQuery.sizeOf(ctx).width * widthFactor,
        decoration: Parts.defaultBoxDecoration,
        child: Form(
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // TODO: localize 2 textfields
              Padding(
                padding: Parts.smallEdgeInsetsAll,
                child: TextFormField(
                  controller: titleCtl,
                  keyboardType: TextInputType.text,
                  onTapOutside: (event) => Focus.of(ctx).unfocus(),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) => descFocus.requestFocus(),
                  // TODO: localize
                  validator: Validatorless.required("title is required!"),
                  decoration: const InputDecoration(
                    labelText: 'Collection Title',
                    icon: Icon(LucideIcons.bookA),
                  ),
                ),
              ),
              Padding(
                padding: Parts.smallEdgeInsetsAll,
                child: TextFormField(
                  controller: descriptionCtl,
                  maxLines: 2,
                  focusNode: descFocus,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.go,
                  onTapOutside: (event) => Focus.of(ctx).unfocus(),
                  onFieldSubmitted: (value) {
                    updateFormData();
                  },
                  decoration: const InputDecoration(
                    labelText: "Descriptions",
                    icon: Icon(LucideIcons.caseLower),
                  ),
                ),
              ),
              Padding(
                padding: Parts.defaultEdgeInsetsVertical,
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  runAlignment: WrapAlignment.center,
                  spacing: SizingScale.small.value,
                  children: [
                    // secondaryTextIconBtn(
                    //   onPressed: () {
                    //     logger.verbose("more option clicked");

                    //   },
                    //   // TODO: localize
                    //   text: const Text("More Options"),
                    // ),
                    filledTextIconBtn(
                      onPressed: () async {
                        logger.verbose("create collection");
                        updateFormData();
                        await SmartDialog.dismiss();
                        await Routing.pushToCollectionDraftScreen();
                      },
                      // TODO: localize
                      text: const Text("CREATE"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlurryContainer.expand(
        blur: 2.5,
        padding: Parts.zeroEdgeInsets,
        child: Padding(
          padding: Parts.defaultEdgeInsetsAll,
          child: Stack(
            alignment: Alignment.center,
            children: [
              layoutBuilder(
                smallLayout: renderPanel(context, ref, heightFactor: 0.5),
                bigLayout: renderPanel(
                  context,
                  ref,
                  widthFactor: 0.5,
                  heightFactor: 0.85,
                ),
              ),
              // TODO: localize
              Align(
                alignment: Alignment.bottomCenter,
                child: filledTextIconBtn(
                  tonal: true,
                  onPressed: () => SmartDialog.dismiss(),
                  text: const Text("CANCEL", textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
