
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';

import '../model/record.dart';
import '../model/write_record.dart';
import '../repository/repository.dart';
import 'common/form_row.dart';
import 'common/nfc_session.dart';
import 'ndef_write_templates.dart';

class EditUriModel with ChangeNotifier {
  EditUriModel(this._repo, this.old) {
    if (old == null) return;
    final record = WellknownUriRecord.fromNdef(old!.record);
    uriController.text = record.uri.toString();
  }

  final Repository _repo;
  final WriteRecord? old;
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController uriController = TextEditingController();


  Stream<Iterable<WriteRecord>> subscribe() {
    return _repo.subscribeWriteRecordList();
  }

  Future<String?> handleTag(NfcTag tag, Iterable<WriteRecord> recordList) async {
    final tech = Ndef.from(tag);

    if (tech == null)
      throw('Tag is not ndef.');

    if (!tech.isWritable)
      throw('Tag is not ndef writable.');

    try {
      final message = NdefMessage(recordList.map((e) => e.record).toList());
      await tech.write(message);
    } on PlatformException catch (e) {
      throw(e.message ?? 'Some error has occurred.');
    }

    return '[Ndef - Write] is completed.';
  }

 //implement saveText, saveUri, saveMime, saveExternal

  Future<Object> saveUri(String URL) async {

    final record = WellknownUriRecord(
      uri: Uri.parse(URL),
    );

    return _repo.createOrUpdateWriteRecord(WriteRecord(
      id: old?.id,
      record: record.toNdef(),
    ));
  }
}

class EditUriPage extends StatelessWidget {

  static Widget withDependency([WriteRecord? record]) => ChangeNotifierProvider<EditUriModel>(
    create: (context) => EditUriModel(Provider.of(context, listen: false), record),
    child: EditUriPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Uri'),
      ),
      body: StreamBuilder<Iterable<WriteRecord>>(
        stream: Provider.of<EditUriModel>(context, listen: false).subscribe(),
        builder: (context, ss) => ListView(
          padding: EdgeInsets.all(2),
          children: [
            FormRow(
              title: Text('Choose template'),
              trailing: Icon(Icons.chevron_right),
              onTap: () async {
                final result = await showDialog<String>(
                  context: context,
                  builder: (context) => SimpleDialog(
                    title: Text('Templates'),
                    children: [
                      SimpleDialogOption(
                        child: Text('Artbyte site'),
                        onPressed: () => Navigator.pop(context, 'www.artbyte.ro'),
                      ),
                      SimpleDialogOption(
                        child: Text('Descriere text'),
                        onPressed: () => Navigator.pop(context, 'Artbyte e cel mai smecher'),
                      ),
                      SimpleDialogOption(
                        child: Text('Mime'),
                        onPressed: () => Navigator.pop(context, 'mime'),
                      ),
                      SimpleDialogOption(
                        child: Text('External'),
                        onPressed: () => Navigator.pop(context, 'external'),
                      ),
                    ],
                  ),
                );
                switch (result) {
                  case 'www.artbyte.ro':
                    Provider.of<EditUriModel>(context, listen: false).saveUri("www.artbyte.ro");
                    break;
                  case 'Artbyte e cel mai smecher':
                    Provider.of<EditUriModel>(context, listen: false).saveText("Artbyte e cel mai smecher"); //implement saveText
                    break;
                  case 'mime':

                    break;
                  case 'external':

                    break;
                  case null:
                    break;
                  default:
                    throw('unsupported: result=$result');
                }
              },
            ),
            FormRow(
              title: Text('Upload', style: TextStyle(color: ss.data?.isNotEmpty != true
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).colorScheme.primary,
              )),
              onTap: ss.data?.isNotEmpty != true
                  ? null
                  : () => startSession(
                context: context,
                handleTag: (tag) => Provider.of<EditUriModel>(context, listen: false).handleTag(tag, ss.data!),
              ),
            ),
            if (ss.data?.isNotEmpty == true)
              FormSection(
                header: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('RECORDS'),
                    Text('${ss.data!.map((e) => e.record.byteLength).reduce((a, b) => a + b)} bytes'),
                  ],
                ),
                children: List.generate(ss.data!.length, (i) {
                  final record = ss.data!.elementAt(i);
                  return WriteRecordFormRow(i, record);
                }),
              ),
          ],
        ),
      ),
      // Form(
      //   key: Provider.of<EditUriModel>(context, listen: false).formKey,
      //   child: ListView(
      //     padding: EdgeInsets.all(24),
      //     children: [
      //       TextFormField(
      //         controller: Provider.of<EditUriModel>(context, listen: false).uriController,
      //         decoration: InputDecoration(labelText: 'Uri', hintText: 'http://example.com', helperText: ''),
      //         keyboardType: TextInputType.url,
      //         validator: (value) => value?.isNotEmpty != true ? 'Required' : Uri.tryParse(value!) == null ? 'Invalid' : null,
      //       ),
      //       SizedBox(height: 12),
      //       ElevatedButton(
      //         child: Text('Save'),
      //         onPressed: () => Provider.of<EditUriModel>(context, listen: false).save(Provider.of<EditUriModel>(context, listen: false).uriController.text)
      //           .then((_) => Navigator.pop(context))
      //           .catchError((e) => print('=== $e ===')),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
