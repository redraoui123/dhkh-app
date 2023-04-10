import 'dart:io';

import 'package:dhkhapp/addPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'main.dart';
import 'classes/Player.dart';
import 'package:intrinsic_grid_view/intrinsic_grid_view.dart';

class PLayersList extends StatefulWidget {
  const PLayersList({super.key, required this.lst_players_tmp});
  final List<Player> lst_players_tmp;
  @override
  State<PLayersList> createState() => _PLayersListState();
}

class _PLayersListState extends State<PLayersList> {
  List<Player> lst_players_tmp = [];
  bool called = false;
  @override
  Widget build(BuildContext context) {
    lst_players_tmp = widget.lst_players_tmp;
    return Container(
      color: const Color(0xFF030A32),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF030A32),
            elevation: 0,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () async {
                  Navigator.pop(context, widget.lst_players_tmp);
                }),
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 25.w),
                  child: InkWell(
                    onTap: () {
                      widget.lst_players_tmp.isEmpty
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddPlayer(
                                  title: 'Add new Player',
                                  lst_players_tmp: widget.lst_players_tmp,
                                  playerTmp: Player(
                                      id: 0,
                                      fullName: "",
                                      phoneNumber: 0,
                                      hasPaid: false,
                                      stripNumber: 0,
                                      images_list: [],
                                      profilePicture: "",
                                      toPay: 0),
                                ),
                              ),
                            ).then((value) {
                              setState(() {
                                lst_players_tmp = value;
                              });
                            })
                          : 0;
                    },
                    child: Icon(
                      widget.lst_players_tmp.isEmpty ? Icons.add : Icons.search,
                    ),
                  )),
            ],
            centerTitle: true,
            title: Text(
              'Players List ',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontFamily: 'Inter',
                fontSize: 25.sp,
              ),
            ),
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              Container(
                color: const Color.fromARGB(255, 6, 0, 85),
                child: Image.asset('images/background.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.fill),
              ),
              widget.lst_players_tmp.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      child: Text(
                        'no players available',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Inter',
                          fontSize: 25.sp,
                        ),
                      ),
                    )
                  : IntrinsicGridView.vertical(
                      columnCount: 2,
                      children: widget.lst_players_tmp
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.only(
                                top: 25.r,
                                right: 20.r,
                                left: 20.r,
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddPlayer(
                                        title:
                                            '${e.fullName!.split(" ")[0]} Details',
                                        lst_players_tmp: widget.lst_players_tmp,
                                        playerTmp: Player(
                                            id: e.id,
                                            fullName: e.fullName,
                                            phoneNumber: e.phoneNumber,
                                            hasPaid: e.hasPaid,
                                            stripNumber: e.stripNumber,
                                            images_list: e.images_list,
                                            profilePicture: e.profilePicture,
                                            toPay: e.toPay),
                                      ),
                                    ),
                                  ).then((value) {
                                    setState(() {
                                      lst_players_tmp = value;
                                    });
                                  });
                                },
                                child: Container(
                                  height: 250.h,
                                  width: 160.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF051152),
                                    border: Border.all(
                                        color: Colors.white, width: 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                            File(e.profilePicture.toString()),
                                            fit: BoxFit.cover,
                                            height: 250.h,
                                            width: 180.w,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.center,
                                        child: Container(
                                          height: 250.h,
                                          width: 160.w,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  const Color(0xFF010B40)
                                                      .withOpacity(.22),
                                                  const Color(0xFF010B40),
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: const [0.6, 1.5]),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 10.r,
                                              left: 10.r,
                                              right: 10.r),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  e.fullName.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: 'Inter',
                                                    fontSize: 17.sp,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.r,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '${e.images_list.length} photos',
                                                      style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.7),
                                                        fontFamily: 'Inter',
                                                        fontSize: 17.sp,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${e.toPay} dhs',
                                                    style: TextStyle(
                                                      color: const Color(
                                                          0xFF7DFFA2),
                                                      fontFamily: 'Inter',
                                                      fontSize: 17.sp,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
