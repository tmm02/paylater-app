import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:paylater/admin/component/RincianCicilanAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme.dart';

class TransaksiPermintaan extends StatefulWidget {
  const TransaksiPermintaan({Key? key}) : super(key: key);

  @override
  State<TransaksiPermintaan> createState() => _TransaksiPermintaanState();
}

class _TransaksiPermintaanState extends State<TransaksiPermintaan> {
  _TransaksiPermintaanState();
  String token = "";
  List datas = [];
  bool isLoading = false;

  void initState() {
    super.initState();
    getOrder();
  }

  Future<void> getOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading = true;
      token = prefs.getString('token')!;
    });
    try {
      Response response = await get(
          Uri.parse('https://paylater.harysusilo.my.id/api/admin/get-order?status=request&page=1'),
          headers: {
            'Authorization': token,
          });
      inspect(response);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        datas =  responseData['data']['data'];
      }else{
        print('gagal');
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PaylaterTheme.spacer,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: isLoading?const LinearProgressIndicator(
        ///style
        valueColor:AlwaysStoppedAnimation<Color>(Colors.grey),
      ):Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: ListView.builder(
              itemCount: datas.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () { Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => RincianCicilanAdmin(
                                order_id: datas[index]['id'],
                                user_id: datas[index]['user_id'],
                              ),
                          ),
                        );},
                        child: Expanded(
                          child: Container(
                            constraints: BoxConstraints(maxWidth: double.infinity),
                            height: 160,
                            width: 360,
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                            decoration: BoxDecoration(
                                color: PaylaterTheme.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          datas[index]['user']['image_face']
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(datas[index]['user']['user_name'],
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w700
                                        )),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                     Image(
                                       image: NetworkImage(datas[index]['image']),
                                       width: 60,
                                       height: 60,
                                       fit: BoxFit.fill,
                                     ),
                                    const SizedBox(width: 20,),
                                    Flexible(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          ///Nama
                                          Text(
                                            datas[index]['title'],
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: PaylaterTheme.darkerText,
                                              fontSize: 16,
                                            ),
                                          ),

                                          /// Tenor cicilan
                                          Text(
                                            '${'Tenor Cicilan :' +
                                                ' ' +
                                                datas[index]['tenor']} bulan',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: PaylaterTheme.darkerText,
                                            ),
                                          ),

                                          ///price
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                            children: [
                                              const Text(
                                                'Harga : ' + 'Rp' + ' ',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: PaylaterTheme.darkerText,
                                                ),
                                              ),
                                              Text(
                                                datas[index]['price'].toString(),
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: PaylaterTheme.orange,
                                                ),
                                              ),
                                            ],
                                          ),

                                          ///notes
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Catatan : ',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                  color: PaylaterTheme.darkerText,
                                                ),
                                              ),
                                              Text(
                                                datas[index]['note'],
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
