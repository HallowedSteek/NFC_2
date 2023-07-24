
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/record.dart';
import '../model/write_record.dart';
import '../repository/repository.dart';

class EditTextModel with ChangeNotifier {
  EditTextModel(this._repo, this.old, this.url) {
    if (old == null) return;
    final record = WellknownTextRecord.fromNdef(old!.record);
    textController.text = record.text;
  }

  final String url;
  final Repository _repo;
  final WriteRecord? old;
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController textController = TextEditingController();

  Future<Object> save() async {
    if (!formKey.currentState!.validate())
      throw('Form is invalid.');

    final record = WellknownTextRecord(
      languageCode: 'en', // todo:
      text: url == "" ? textController.text : url,
    );

    return _repo.createOrUpdateWriteRecord(WriteRecord(
      id: old?.id,
      record: record.toNdef(),
    ));
  }
}

class EditTextPage extends StatelessWidget {
  EditTextPage(String? url);
  String? url;

  static Widget withDependency(String url,[WriteRecord? record]) => ChangeNotifierProvider<EditTextModel>(
    create: (context) =>EditTextModel(Provider.of(context, listen: false), record, url),
    child: EditTextPage(url),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Text'),
      ),
      body: Form(
        key: Provider.of<EditTextModel>(context, listen: false).formKey,
        child: ListView(
          padding: EdgeInsets.all(24),
          children: [
            TextFormField(
              controller: Provider.of<EditTextModel>(context, listen: false).textController,
              decoration: InputDecoration(labelText: "", helperText: ''),
              keyboardType: TextInputType.text,
              validator: (value) => value?.isNotEmpty != true ? 'Required' : null,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () => Provider.of<EditTextModel>(context, listen: false).save()
                .then((_) => Navigator.pop(context))
                .catchError((e) => print('=== $e ===')),
            ),
          ],
        ),
      ),
    );
  }
}