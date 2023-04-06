import 'package:dhkhapp/addPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'main.dart';
import 'classes/Player.dart';
import 'package:intrinsic_grid_view/intrinsic_grid_view.dart';

class PLayersList extends StatefulWidget {
  const PLayersList({super.key});

  @override
  State<PLayersList> createState() => _PLayersListState();
}

bool _tmpfilled = true;
List<Player> players1 = [];
List<Player> players = [
  Player(
      id: 1,
      fullName: 'Youssef Oubaba',
      phoneNumber: 0615487950,
      stripNumber: 17,
      profilePicture: 'images/Profile Pictures/oubaba.png',
      images_list: [
        'images/image list/yousesf/1.jpg',
        'images/image list/yousesf/2.jpg',
        'images/image list/yousesf/3.jpg',
        'images/image list/yousesf/4.jpg',
      ],
      hasPaid: false,
      toPay: 25),
  Player(
      id: 1,
      fullName: 'Jawad Mofdi',
      phoneNumber: 0625441120,
      stripNumber: 8,
      profilePicture: 'images/Profile Pictures/jawad.png',
      images_list: [
        'images/image list/jawad/1.jpg',
        'images/image list/jawad/2.jpg',
        'images/image list/jawad/3.jpg',
        'images/image list/jawad/4.jpg',
        'images/image list/jawad/5.jpg',
        'images/image list/jawad/6.jpg',
      ],
      hasPaid: false,
      toPay: 20),
  Player(
      id: 1,
      fullName: 'Omar Boudi',
      phoneNumber: 0714856230,
      stripNumber: 23,
      profilePicture: 'images/Profile Pictures/boudi.png',
      images_list: [
        'images/image list/omar/1.jpg',
        'images/image list/omar/2.jpg',
      ],
      hasPaid: false,
      toPay: 10),
  Player(
      id: 1,
      fullName: 'Soulayman taouyl',
      phoneNumber: 0658441177,
      stripNumber: 15,
      profilePicture: 'images/Profile Pictures/soulayman.png',
      images_list: [
        'images/image list/soulayman/1.jpg',
        'images/image list/soulayman/2.jpg',
        'images/image list/soulayman/3.jpg',
      ],
      hasPaid: false,
      toPay: 15),
  Player(
      id: 1,
      fullName: 'Abdessamad Saoud',
      phoneNumber: 0620558860,
      stripNumber: 15,
      profilePicture: 'images/Profile Pictures/samati.png',
      images_list: [
        'images/image list/samati/1.jpg',
        'images/image list/samati/2.jpg',
        'images/image list/samati/3.jpg',
        'images/image list/samati/4.jpg',
      ],
      hasPaid: false,
      toPay: 20),
  Player(
      id: 1,
      fullName: 'Hamza Yaani',
      phoneNumber: 0706054488,
      stripNumber: 15,
      profilePicture: 'images/Profile Pictures/pogba.png',
      images_list: [
        'images/image list/pogba/1.jpg',
        'images/image list/pogba/2.jpg',
        'images/image list/pogba/3.jpg',
      ],
      hasPaid: false,
      toPay: 20),
];

class _PLayersListState extends State<PLayersList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF030A32),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF030A32),
            elevation: 0,
            actions: [
              Padding(
                  padding: EdgeInsets.only(right: 25.w),
                  child: InkWell(
                    onTap: () {
                      players1.isEmpty
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddPlayer()))
                          : 0;
                    },
                    child: Icon(
                      players1.isEmpty ? Icons.add : Icons.search,
                    ),
                  )),
            ],
            centerTitle: true,
            title: InkWell(
              onTap: () {
                if (_tmpfilled) {
                  setState(() {
                    for (var player in players) {
                      players1.add(player);
                    }
                    _tmpfilled = false;
                    print(' tmpfilled =' +
                        _tmpfilled.toString() +
                        ' // Players 1 : ' +
                        players1.length.toString() +
                        ' // Players :' +
                        players.length.toString());
                  });
                } else {
                  setState(() {
                    players1 = [];
                    _tmpfilled = true;
                    print(' tmpfilled =' +
                        _tmpfilled.toString() +
                        ' // Players 1 : ' +
                        players1.length.toString() +
                        ' // Players :' +
                        players.length.toString());
                  });
                }
              },
              child: Text(
                'Players List ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w100,
                  fontFamily: 'Inter',
                  fontSize: 25.sp,
                ),
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
              players1.isEmpty
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
                      children: players
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.only(
                                top: 25.r,
                                right: 20.r,
                                left: 20.r,
                              ),
                              child: Container(
                                height: 250.h,
                                width: 160.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF051152),
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          e.profilePicture.toString(),
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
                                                    color: Color(0xFF7DFFA2),
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
