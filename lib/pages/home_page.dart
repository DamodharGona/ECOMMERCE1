import 'package:ecommerce/components/circle_image.dart';
import 'package:ecommerce/components/my_drawer.dart';
import 'package:ecommerce/pages/pant_page.dart';
import 'package:ecommerce/pages/shirt_page.dart';
import 'package:ecommerce/pages/shoe_page.dart';
import 'package:ecommerce/pages/t_shirt_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    

    List<String> collections = [
      'assets/images/sht2.png',
      'assets/images/tsht1.png',
      'assets/images/pant2.png',
      'assets/images/shoe4.png',
    ];
    List<String> _images = [
      'assets/images/sht1.png',
      'assets/images/tsht1.png',
      'assets/images/jeans1.png',
      'assets/images/shoe.png',
    ];
    List<String> _text = [
      'shirt',
      'T-shirt',
      'pant',
      'shoe',
    ];
    List<Widget> __pages = [
      const ShirtPage(),
      const TShirtPage(),
      const PantPage(),
      const ShoePage(),
    ];
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        actions: const [
          Icon(
            Icons.notifications_none_outlined,
            size: 28,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      drawer:  MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.grey.shade300],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Fashion',
                          style: TextStyle(
                            color: Colors.grey.shade200,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          'Collection',
                          style: TextStyle(
                            color: Colors.grey.shade200,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Image(
                        image: AssetImage('assets/images/shirt.png'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: _images.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: CircleImage(
                          image: _images[index],
                          size: 80.0,
                          color: Colors.grey.shade300,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => __pages[index],
                              ),
                            );
                          },
                        ),
                      ),
                      Text(
                        _text[index],
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Check out some collections',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    width: 250,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Image(image: AssetImage(collections[index])),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
