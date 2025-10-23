import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pudding/common/components/btns.dart'
    show filledTextIconBtn, clearTextFieldIconBtn;
import 'package:pudding/common/components/view_wrappers.dart'
    show layoutBuilder;
import 'package:pudding/common/parts.dart' show Parts, SizingScale;
import 'package:pudding/common/utils/utils.dart' show unfocus;
import 'package:validatorless/validatorless.dart';

// TODO: complete this
class NewPuddingFormPanel extends ConsumerStatefulWidget {
  const NewPuddingFormPanel({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewCollectionFormPanelState();
}

class _NewCollectionFormPanelState extends ConsumerState<NewPuddingFormPanel> {
  final urlFocusNode = FocusNode(debugLabel: 'urlField');
  final notesFocusNode = FocusNode(debugLabel: 'notesField');
  final TextEditingController urlCtl = TextEditingController();
  final TextEditingController notesCtl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    urlFocusNode.addListener(_updateFocusStatus);
    notesFocusNode.addListener(_updateFocusStatus);
    super.initState();
  }

  @override
  void dispose() {
    urlCtl.dispose();
    notesCtl.dispose();
    urlFocusNode.dispose();
    notesFocusNode.dispose();
    super.dispose();
  }

  void updateFormData() {
    // TODO: complete this
    // final now = Timestamp.now();
    // return ref
    //     .read(collectionDraftProvider.notifier)
    //     .updateImportantProps(
    //       sameCreateUpdateTime: true,
    //       now: now,
    //       newDes: notesCtl.text.trim(),
    //       newTitle: urlCtl.text.trim(),
    //     );
  }

  void _updateFocusStatus() => setState(() {});

  bool isAnyOfTheFieldsHasFocus() =>
      urlFocusNode.hasFocus || notesFocusNode.hasFocus;

  bool validateForm() {
    final formCheck = formKey.currentState?.validate();
    return formCheck ?? false;
  }

  Future<void> onStartCookingBtnClicked() async {
    updateFormData();

    // TODO: complete this
    // final c = ref.read(collectionDraftProvider.notifier).obj;
    // if (validateForm() && c != null) {
    //   await ref.read(collectionsRepositoryProvider).addCollection(c);
    //   ref.invalidate(collectionDraftProvider);
    //   await SmartDialog.dismiss();
    // }
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
                    // pudding url
                    controller: urlCtl,
                    focusNode: urlFocusNode,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    onTapOutside: (event) => unfocus(context),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) => notesFocusNode.requestFocus(),
                    // TODO: localize
                    validator: Validatorless.required("url is required!"),
                    decoration: InputDecoration(
                      labelText: 'URL',
                      filled: true,
                      icon: const Icon(LucideIcons.link2),
                      suffixIcon: clearTextFieldIconBtn(
                        onPressed: () => urlCtl.clear(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: Parts.customEdgeInsetsHorizontal(SizingScale.small),
                  child: TextFormField(
                    // notes box
                    controller: notesCtl,
                    maxLines: 2,
                    focusNode: notesFocusNode,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    onTapOutside: (event) => unfocus(context),
                    onFieldSubmitted: (value) {
                      updateFormData();
                    },
                    decoration: InputDecoration(
                      labelText: "Notes",
                      icon: const Icon(LucideIcons.scrollText),
                      suffixIcon: clearTextFieldIconBtn(
                        onPressed: () => notesCtl.clear(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: Parts.customEdgeInsetsVertical(SizingScale.small),
                  child: filledTextIconBtn(
                    onPressed: () async => await onStartCookingBtnClicked(),
                    // TODO: localize
                    text: const Text("START COOKING"),
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
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BlurryContainer.expand(
        blur: 2.5,
        padding: Parts.zeroEdgeInsets,
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
