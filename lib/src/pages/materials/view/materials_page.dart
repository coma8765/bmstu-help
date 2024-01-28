import 'package:bmstu_help/src/domain/university/model.dart';
import 'package:bmstu_help/src/pages/materials/widgets/widgets.dart';
import 'package:bmstu_help/src/shared/mock/mock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MaterialsPage extends StatelessWidget {
  const MaterialsPage({super.key});

  static const String route = '/university';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appBarTitle),
        automaticallyImplyLeading: false,
      ),
      body: const _MaterialDialog(),
    );
  }
}

class _MaterialDialog extends StatefulWidget {
  const _MaterialDialog();

  @override
  State<StatefulWidget> createState() => _MaterialDialogState();
}

enum _DialogStates { chooseSubject, chooseContent }

class _MaterialDialogState extends State<_MaterialDialog> {
  _DialogStates state = _DialogStates.chooseSubject;

  String? _subjectId;

  List<Subject>? subjects;
  List<Content>? contents;

  @override
  void initState() {
    super.initState();

    subjects = SubjectFactory().generateFakeList(length: 10);
    contents = ContentFactory().generateFakeList(
      length: 10,
      subjectId: _subjectId,
    );
  }

  void _setSubjectId(String id) {
    setState(() {
      _subjectId = id;
      state = _DialogStates.chooseContent;
    });
  }

  void _clearSubjectId() {
    setState(() {
      _subjectId = null;
      state = _DialogStates.chooseSubject;
    });
  }

  void _cancelCallback() {
    switch (state) {
      case _DialogStates.chooseSubject:
        Navigator.of(context).pop(); // Leave from intent
      case _DialogStates.chooseContent:
        _clearSubjectId();
    }
  }

  @override
  Widget build(BuildContext context) {
    late String appBarTitle;
    late Widget child;

    switch (state) {
      case _DialogStates.chooseSubject:
        appBarTitle = AppLocalizations.of(context)!.universityChooseSubject;

        child = Selector(
          items: subjects!.map((e) => Item(id: e.id, title: e.title)).toList(),
          callback: _setSubjectId,
        );
      case _DialogStates.chooseContent:
        appBarTitle = AppLocalizations.of(context)!.universityChooseContent;

        child = ContentList(content: contents!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: _cancelCallback,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: child,
      ),
    );
  }
}
