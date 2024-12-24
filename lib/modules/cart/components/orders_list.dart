import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:produce_pos/core/constants/app_colors.dart';
import 'package:produce_pos/core/constants/app_defaults.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    var data = null;
    return Positioned(
        bottom: 30.h,
        left: 10.w,
        right: 10.w,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(
              AppDefaults.padding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Orders',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 43.sp,
                          color: Colors.black)),
                ),
                InkWell(
                  child: Row(
                    children: [
                      Text(
                        'View All ',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 40.sp,
                                color: AppColors.primary)),
                      ),
                      Icon(Icons.arrow_forward_rounded,
                          size: 60.sp, color: AppColors.primary)
                    ],
                  ),
                  // onTap: () => Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const OrdersScreen())),
                ),
              ],
            ),
          ),
          Container(
              margin: const EdgeInsets.only(
                  left: AppDefaults.padding * 0.2,
                  right: AppDefaults.padding * 0.2),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(color: Color.fromARGB(255, 242, 241, 241)),
                ],
              ),
              child: ListView(
                children: [
                  DataTable(
                    columns: [
                      DataColumn(
                          label: Text(
                        'Order Number',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 30.sp,
                            color: Colors.black),
                      )),
                      DataColumn(
                        label: Text(
                          'Order State',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 30.sp,
                              color: Colors.black),
                        ),
                      ),
                      DataColumn(
                          label: Text(
                        'Order Time',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 30.sp,
                            color: Colors.black),
                      ))
                    ],
                    rows: List<DataRow>.generate(
                        data.length,
                        (index) => DataRow(cells: [
                              DataCell(
                                Text(
                                  '${data[index]['id']}'.substring(0, 6),
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 35.sp,
                                          color: Colors.black38)),
                                ),
                              ),
                              DataCell(
                                Text(
                                  '${data[index]['status']}',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 35.sp,
                                          color: Colors.black38)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              DataCell(Text(
                                '${'${data[index]['orderTime']}'.substring(0, 7)}',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 35.sp,
                                        color: Colors.black38)),
                              ))
                            ])),
                  ),
                ],
              ))
        ]));
    ;
  }
}
