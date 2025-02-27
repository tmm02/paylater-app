import 'package:flutter/material.dart';
import 'package:paylater/admin/component/popup.dart';
import 'package:paylater/theme.dart';
import 'package:paylater/user/HomePage.dart';

class CreateAkun extends StatefulWidget {
  const CreateAkun({Key? key}) : super(key: key);

  @override
  State<CreateAkun> createState() => _CreateAkunState();
}

class _CreateAkunState extends State<CreateAkun> {
  TextEditingController inputnama = TextEditingController();
  TextEditingController inputtelp = TextEditingController();
  TextEditingController inputemail = TextEditingController();
  String? _selectedItem;

  @override
  void dispose() {
    inputnama.dispose();
    inputtelp.dispose();
    inputemail.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PaylaterTheme.white,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text('Membuat Akun',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: PaylaterTheme.darkText,
              )),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: PaylaterTheme.darkText,
              size: 20,
            )),
      ),
      body: Container(
        color: PaylaterTheme.spacer,
        child: ListView(physics: const ClampingScrollPhysics(), children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 20,
                ),
                //Username
                const Text(
                  'Username',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: PaylaterTheme.grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  // selectionHeightStyle:
                  //     BoxHeightStyle.includeLineSpacingMiddle,
                  controller: inputnama,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: 'Masukan Username',
                      hintStyle:
                          TextStyle(color: PaylaterTheme.deactivatedText),
                      filled: true,
                      fillColor: PaylaterTheme.white),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                //End Username
                const SizedBox(
                  height: 10,
                ),

                //Nomor Telepon
                const Text(
                  'Nomor Telepon',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: PaylaterTheme.grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Flexible(
                      flex: 2,
                      child: TextField(
                        enabled: false,
                        maxLines: 1,
                        decoration: InputDecoration(
                            labelStyle: TextStyle(),
                            labelText: '+62',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5.0, horizontal: 15.0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            filled: true,
                            fillColor: PaylaterTheme.white),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      flex: 8,
                      fit: FlexFit.tight,
                      child: SizedBox(
                        width: double.infinity,
                        child: TextField(
                          controller: inputtelp,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 15.0),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              hintText: 'Masukan Nomor Telepon',
                              hintStyle: TextStyle(
                                  color: PaylaterTheme.deactivatedText),
                              filled: true,
                              fillColor: PaylaterTheme.white),
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //End Nomor Telepon

                const SizedBox(
                  height: 10,
                ),

                //Nomor Telepon
                const Text(
                  'Email',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: PaylaterTheme.grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  // selectionHeightStyle:
                  //     BoxHeightStyle.includeLineSpacingMiddle,
                  controller: inputemail,
                  maxLines: 1,
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      hintText: 'Masukan Email',
                      hintStyle:
                          TextStyle(color: PaylaterTheme.deactivatedText),
                      filled: true,
                      fillColor: PaylaterTheme.white),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                const Text(
                  'Akses',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: PaylaterTheme.grey),
                ),
                const SizedBox(
                  height: 5,
                ),

                DropdownButtonFormField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    filled: true,
                    fillColor: PaylaterTheme.white,
                  ),
                  dropdownColor: PaylaterTheme.white,
                  hint: Text(
                    "Choose",
                    style: TextStyle(
                        color: PaylaterTheme.deactivatedText,
                        fontWeight: FontWeight.w600),
                  ),
                  value: _selectedItem,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedItem = newValue!;
                    });
                  },
                  items: <String>['Admin', 'Pengawas', 'Customer']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: PaylaterTheme.grey),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 100,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      child: const Text("Buat Akun"),
                      style: ElevatedButton.styleFrom(
                        primary: PaylaterTheme.maincolor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        Popup.confirmDialog(context,
                            message: "Yakin untuk membuat akun?",
                            dialogCallback: (value) async {
                          if (value == 'Confirm') {
                            Navigator.of(context).pop();
                          }
                          if (value == 'Cancel') {}
                        });
                      },
                    ),
                    ElevatedButton(
                      child: const Text("Cancel"),
                      style: ElevatedButton.styleFrom(
                        primary: PaylaterTheme.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
