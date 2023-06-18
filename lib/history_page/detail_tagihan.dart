import 'package:flutter/material.dart';
import 'package:paylater/history_page/history_order.dart';
import 'package:paylater/history_page/history_transaksi.dart';
import 'package:paylater/history_page/rincianPembayaran.dart';
import 'package:paylater/user/tagihanComponent/detailTagihan/rincianProduct.dart';

class DetailTagihan extends StatefulWidget {
  const DetailTagihan({Key? key}) : super(key: key);

  @override
  _DetailTagihanState createState() => _DetailTagihanState();
}

class _DetailTagihanState extends State<DetailTagihan> {
  int pageIndex = 0;

  final pages = [
    HistoryOrder(),
    HistoryTransaksi(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: Duration(seconds: 2),
      length: 4 ,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff025464),
          leading: BackButton(color: Colors.white,),
          title: Text("Detail tagihan", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
          centerTitle: true,
        ),
        body:Container(
          width: double.maxFinite,
          color: Color(0xffE3E9EB),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              Column(
                children: [
                  SizedBox(height: 20,),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.symmetric(horizontal: 90, vertical: 12),
                    child: Text('Cicilan Berlangsung', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  ),

                  SizedBox(height: 30,),

                  //produk
                  RincianProduct(),

                  //Rincian Cicilan Pembayaran
                  SizedBox(height: 30,),
                  RincianPembayaran(),

                  //button bayar cicilan
                  SizedBox(height: 40,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    margin: EdgeInsets.symmetric(horizontal: 65),
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Color(0xff025464),
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10,),
                        Text('Bayar Cicilan',
                          style: TextStyle(
                              color: Color(0xff025464),
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    margin: EdgeInsets.symmetric(horizontal: 65),
                    height: 40,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          style: BorderStyle.solid,
                          color: Color(0xff1288B5),
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10,),
                        Text('Bayar Seluruh Tagihan',
                          style: TextStyle(
                              color: Color(0xff1288B5),
                              fontSize: 14,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ]
          ),
        ),
      ),
    );
  }
}