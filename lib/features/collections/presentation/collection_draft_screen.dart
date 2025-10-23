import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pudding/common/components/btns.dart'
    show editableModeIconBtnSwitch, clearTextFieldIconBtn;
import 'package:pudding/common/components/view_wrappers.dart';
import 'package:pudding/common/parts.dart';
import 'package:pudding/core/models/appbar_cfg_model.dart';
import 'package:pudding/features/collections/providers/collections_providers.dart'
    show collectionDraftProvider;
import 'package:validatorless/validatorless.dart';

/// also known as `CookingCollectionScreen`
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
  }

  void unfocus() => FocusScope.of(context).unfocus();

  @override
  void dispose() {
    // TODO: implement dispose
    titleCtl.dispose();
    descriptionCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return pageViewWrapper(
      appBarCfg:
          // TODO: localize
          AppbarCfgModel(
            titleStr: "Cooking Collection",
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
                  isSelected: !isEditable,
                ),
              ),
            ],
          ),
      body: Center(
        child: Padding(
          padding: Parts.bigEdgeInsetsAll,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              autovalidateMode: AutovalidateMode.onUnfocus,
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: SizingScale.lessMedium.value,
                runAlignment: WrapAlignment.spaceAround,
                runSpacing: SizingScale.moreMedium.value,
                children: [
                  renderAnimatedFormElement(
                    editableWidget: renderEditableTextBox(
                      key: const ValueKey('editable-title'),
                      labelText: "Title",
                      ctl: titleCtl,
                      prefixIcon: const Icon(LucideIcons.bookA),
                      validator: Validatorless.required("title is required"),
                    ),
                    readOnlyWidget: Text(
                      titleCtl.text,
                      key: const ValueKey('readOnly-title'),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  renderAnimatedFormElement(
                    editableWidget: renderEditableTextBox(
                      key: const ValueKey('editable-desc'),
                      labelText: "Descriptions",
                      ctl: descriptionCtl,
                      prefixIcon: const Icon(LucideIcons.caseLower),
                      maxLines: 3,
                    ),
                    readOnlyWidget: Text(
                      titleCtl.text,
                      key: const ValueKey('readOnly-desc'),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget renderReadOnlyText({required Icon prefixIcon}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Expanded(child: Stack(children: [

],))],
    );
  }

  TextFormField renderEditableTextBox({
    required ValueKey<String> key,
    required TextEditingController ctl,
    required Icon prefixIcon,
    String labelText = 'textbox',
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return TextFormField(
      key: key,
      controller: ctl,
      validator: validator,
      maxLines: maxLines,
      onTapOutside: (event) => unfocus(),
      decoration: InputDecoration(
        filled: true,
        icon: prefixIcon,
        labelText: labelText,
        suffixIcon: clearTextFieldIconBtn(onPressed: () => ctl.clear()),
      ),
    );
  }

  /// render the appropriate widget based on the mode (editable/read-only)
  ///
  /// please also specify the key for both widgets
  AnimatedSwitcher renderAnimatedFormElement({
    required Widget editableWidget,
    required Widget readOnlyWidget,
  }) {
    assert(editableWidget.key != null && readOnlyWidget.key != null);
    return AnimatedSwitcher(
      duration: Parts.defaultAnimatedSwitcherDuration,
      // TODO: optionally customize the transition (e.g., more advance animation)
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: isEditable ? editableWidget : readOnlyWidget,
    );
  }
}
