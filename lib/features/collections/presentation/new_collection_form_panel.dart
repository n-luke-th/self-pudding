import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pudding/common/components/btns.dart'
    show filledTextIconBtn, clearTextFieldIconBtn, secondaryTextIconBtn;
import 'package:pudding/common/components/view_wrappers.dart'
    show layoutBuilder, blurryBackgroundContent;
import 'package:pudding/common/parts.dart' show Parts, SizingScale;
import 'package:pudding/common/utils/utils.dart' show unfocus;
import 'package:pudding/core/navigation/routing.dart';
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
  final titleFocusNode = FocusNode(debugLabel: 'collectionTitleField');
  final descFocusNode = FocusNode(debugLabel: 'collectionDescField');
  final TextEditingController titleCtl = TextEditingController();
  final TextEditingController descriptionCtl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setInitialValues();
    titleFocusNode.addListener(_updateFocusStatus);
    descFocusNode.addListener(_updateFocusStatus);
    super.initState();
  }

  @override
  void dispose() {
    titleCtl.dispose();
    descriptionCtl.dispose();
    titleFocusNode.dispose();
    descFocusNode.dispose();
    super.dispose();
  }

  void setInitialValues() {
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

  void _updateFocusStatus() => setState(() {});

  bool isAnyOfTheFieldsHasFocus() =>
      titleFocusNode.hasFocus || descFocusNode.hasFocus;

  bool validateForm() {
    final formCheck = formKey.currentState?.validate();
    return formCheck ?? false;
  }

  Future<void> onMoreBtnClicked() async {
    if (validateForm()) {
      updateFormData();
      await SmartDialog.dismiss();
      await Routing.pushToCollectionDraftScreen();
    }
  }

  Future<void> onCreateBtnClicked() async {
    updateFormData();
    final c = ref.read(collectionDraftProvider.notifier).obj;
    if (validateForm() && c != null) {
      await ref.read(collectionsRepositoryProvider).addCollection(c);
      ref.invalidate(collectionDraftProvider);
      await SmartDialog.dismiss();
    }
  }

  Widget renderPanel(WidgetRef ref, {double widthFactor = 0.7}) {
    return Padding(
      padding: Parts.smallEdgeInsetsAll,
      child: Container(
        // height: MediaQuery.sizeOf(ctx).height * heightFactor,
        width: MediaQuery.sizeOf(context).width * widthFactor,
        decoration: Parts.defaultBoxDecoration,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // TODO: localize 2 textfields
                Padding(
                  padding: Parts.customEdgeInsetsBidirectional(
                    horizontal: SizingScale.small,
                    vertical: SizingScale.tiny,
                  ),
                  child: TextFormField(
                    // collection title
                    controller: titleCtl,
                    focusNode: titleFocusNode,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    onTapOutside: (event) => unfocus(context),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) => descFocusNode.requestFocus(),
                    // TODO: localize
                    validator: Validatorless.required("title is required!"),
                    decoration: InputDecoration(
                      labelText: 'Title',
                      filled: true,
                      icon: const Icon(LucideIcons.bookA),
                      suffixIcon: clearTextFieldIconBtn(
                        onPressed: () => titleCtl.clear(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: Parts.customEdgeInsetsHorizontal(SizingScale.small),
                  child: TextFormField(
                    // description box
                    controller: descriptionCtl,
                    maxLines: 2,
                    focusNode: descFocusNode,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    onTapOutside: (event) => unfocus(context),
                    onFieldSubmitted: (value) {
                      updateFormData();
                    },
                    decoration: InputDecoration(
                      labelText: "Descriptions",
                      icon: const Icon(LucideIcons.caseLower),
                      suffixIcon: clearTextFieldIconBtn(
                        onPressed: () => descriptionCtl.clear(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: Parts.customEdgeInsetsVertical(SizingScale.small),
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    runAlignment: WrapAlignment.center,
                    spacing: SizingScale.small.value,
                    children: [
                      secondaryTextIconBtn(
                        onPressed: () async {
                          await onMoreBtnClicked();
                        },
                        // TODO: localize
                        text: const Text("More"),
                      ),
                      filledTextIconBtn(
                        onPressed: () async => await onCreateBtnClicked(),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: blurryBackgroundContent(
        child: Padding(
          padding: Parts.smallEdgeInsetsAll,
          child: Stack(
            alignment: Alignment.center,
            children: [
              layoutBuilder(
                smallLayout: renderPanel(ref, widthFactor: 0.82),
                bigLayout: renderPanel(ref, widthFactor: 0.5),
              ),
              // TODO: localize
              Visibility(
                visible: !isAnyOfTheFieldsHasFocus(),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: filledTextIconBtn(
                    tonal: true,
                    onPressed: () async {
                      updateFormData();
                      await SmartDialog.dismiss();
                    },
                    text: const Text("CANCEL", textAlign: TextAlign.center),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
