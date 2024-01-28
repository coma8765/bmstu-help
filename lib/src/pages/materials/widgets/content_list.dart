import 'package:bmstu_help/src/domain/university/model.dart';
import 'package:bmstu_help/src/services/services.dart';
import 'package:file_icon/file_icon.dart';
import 'package:flutter/material.dart';

class ContentItem extends StatelessWidget {
  const ContentItem({super.key, required this.singleContent});

  final Content singleContent;

  Future<void> downloadCallback(BuildContext context) async {
    final alertDialog = AlertDialog(
      title: Text(
        // TODO(coma8765): add failure type
        AppLocalizations.of(context)!.downloadFailure,
      ),
    );

    Future<void> failureCallback() => showDialog<void>(
          context: context,
          builder: (BuildContext context) => alertDialog,
        );

    await getIt.get<HTTP>().downloadFile(
          url: singleContent.fileUrl,
          filename: singleContent.fileName,
          failureCallback: failureCallback,
          open: true,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: FileIcon(singleContent.fileName, size: 24),
          ),
          Expanded(
            child: ExpansionTile(
              shape: const Border(),
              title: Text(singleContent.title),
              subtitle: Text('filename: ${singleContent.fileName}'),
              children: <Widget>[
                GestureDetector(
                  child: Text(AppLocalizations.of(context)!.downloadFile),
                  onTap: () => downloadCallback(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContentList extends StatelessWidget {
  const ContentList({super.key, required this.content});

  final List<Content> content;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: content
          .map(
            (Content e) => ContentItem(singleContent: e),
          )
          .toList(),
    );
  }
}
