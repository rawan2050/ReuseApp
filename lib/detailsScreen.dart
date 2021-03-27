
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reuse_app/item_notifier.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'auth_provider.dart';


class DetailScreen extends StatefulWidget {
  static String id = 'Item';
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List image;
  String price ;
  CollectionReference _auctionItems = FirebaseFirestore.instance.collection('auctionItems');
   final useId =  FirebaseAuth.instance.currentUser.uid;
  CollectionReference _donatedItems =
  FirebaseFirestore.instance.collection('donatedItems');
   String docId ;

  Future<void> createSubCollectionForAucthion(){
    _auctionItems.doc(docId).collection('auctioneer').add({
      'price': price,
      'userId' :  useId,
    });
  }
  Future<void> createSubCollectionForDonating(){
    _donatedItems.doc(docId).collection('requests').add({
      'userId' :  useId,
    });
  }
  @override
  Widget build(BuildContext context) {
    ItemNotifier itemNotifier =
        Provider.of<ItemNotifier>(context, listen: false);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    List<NetworkImage> list = new List<NetworkImage>();
    docId = itemNotifier.currentItem.documentId;
    image = itemNotifier.currentItem.image;
    for (var i = 0; i < image.length; i++) {
      list.add(NetworkImage(itemNotifier.currentItem.image[i]));
    }

    String isAuction() {
      if (itemNotifier.currentItem.type == 'مزاد') {
        return 'شارك بالمزاد';
      } else {
        return 'ارسل طلب';
      }
    }

    return Scaffold(
      backgroundColor: Color(0xffF7F7F7),
      appBar: AppBar(
        title: Center(child: Text('منتج')),
        backgroundColor: Color(0xff4072AF),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Center(
                  child: SizedBox(
                    height:400.0,
                    width: MediaQuery.of(context).size.width,
                    child: Carousel(
                      boxFit: BoxFit.cover,
                      autoplay: false,
                      animationCurve: Curves.fastOutSlowIn,
                      animationDuration: Duration(milliseconds: 1000),
                      dotSize: 6.0,
                      dotIncreasedColor: Color(0xFFFF335C),
                      dotBgColor: Colors.transparent,
                      dotPosition: DotPosition.bottomCenter,
                      dotVerticalPadding: 10.0,
                      showIndicator: true,
                      indicatorBgPadding: 7.0,
                      images: list,
                    ),
                  ),
                ),
              ),

              /*  CarouselSlider(
                items: [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.,
                  ),
                ],
                options: CarouselOptions(
                  height: 220,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
                items: [

                  Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.network(),
                  ),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('images/2.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: AssetImage('images/3.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),*/
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RaisedButton(
                        shape: StadiumBorder(),
                        disabledColor: Color(0xFF027843),
                        child: Text(
                          itemNotifier.currentItem.type,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        )),
                    Text(
                      itemNotifier.currentItem.name,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ],
                  ),
              ),
            if(itemNotifier.currentItem.type == 'مزاد')...[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                   children:[
                     Container(
                       padding: EdgeInsets.all(5.0),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(20.0)),
                         color: Color(0xFF027843),
                       ),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Icon(Icons.monetization_on_outlined , color: Colors.white,),

                           Text(itemNotifier.currentItem.price,style: TextStyle(color: Colors.white),),
                         ],
                       ),
                     ),
                   ],

                ),
              ),
            ],

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'تفاصيل المنتج',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100.0,
                  child: Text(
                    itemNotifier.currentItem.details,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    shape: StadiumBorder(),
                    color: Color(0xFF027843),
                    child: Text(
                      'تواصل',
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ),
                        textAlign: TextAlign.center
                    ),
                    onPressed: () {
                      if (authProvider.isAuthenticated) {} // for chat leave it until the feature complete ..
                      if (!authProvider.isAuthenticated) {
                        showAlertDialog(context);
                      }
                    },
                  ),
                  RaisedButton(
                    shape: StadiumBorder(),
                    color: Color(0xFF027843),
                    child: Text(
                      isAuction(), // donating or auction
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      if (authProvider.isAuthenticated) {
                        if (itemNotifier.currentItem.type == 'مزاد') {
                          _showDialog();
                        }
                        if (itemNotifier.currentItem.type == 'تبرع') {
                          createSubCollectionForDonating();
                          showDonatingDialog(context);
                        }
                      }
                      if (!authProvider.isAuthenticated) {
                       showAlertDialog(context);
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

  }
  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("موافق"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Directionality(child: Text("غير مسجل"),textDirection: TextDirection.rtl),
      content: Directionality(child: Text("يجب تسجيل الدخول حتى تتمكن من استخدام الميزة"), textDirection: TextDirection.rtl),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  // show dialog for enter the price
_showDialog() async{
    await showDialog<String>(
      context: context,
      child: _SystemPadding(child: AlertDialog(
        contentPadding: EdgeInsets.all(16.0),
        content: Row(
          children: [
            Expanded(
              child: TextField(
                textAlign: TextAlign.end,
                textDirection: TextDirection.rtl,
                keyboardType: TextInputType.number ,
                decoration: InputDecoration(
                  labelText: 'ادخل المبلغ',
                  labelStyle: TextStyle(

                  ),
                ),
                 onChanged: (value){
                  setState(() {
                    price = value;
                  });
                  },
              ),
            ),
          ],
        ),
        actions: [
          FlatButton(
            child: Text('تأكيد'),
            onPressed: (){
              Navigator.pop(context);
              if(price != null){
                createSubCollectionForAucthion();
              }
            },
          ),
        ],
      ),
      ),
    );
}
// dialog for conformation the donating process
  showDonatingDialog(BuildContext context) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("موافق"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Directionality(child: Text("تم ارسال الطلب"),textDirection: TextDirection.rtl),
      content: Directionality(child: Text("تم ارسال الطلب لصاحب المنتج وسيتم التواصل معكم في حال الموافقة"), textDirection: TextDirection.rtl),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
class _SystemPadding extends StatelessWidget {
  final Widget child;

  _SystemPadding({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return new AnimatedContainer(
        padding: mediaQuery.viewInsets,
        duration: const Duration(milliseconds: 300),
        child: child
    );
  }
}
