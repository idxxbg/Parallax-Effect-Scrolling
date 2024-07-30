import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ParallxEffect(),
    );
  }
}

class ParallxEffect extends StatefulWidget {
  const ParallxEffect({super.key});

  @override
  State<ParallxEffect> createState() => _ParallxEffectState();
}

class _ParallxEffectState extends State<ParallxEffect> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
    scrollController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<String> texts = [
      'Parallax Effect',
      'Beauty of Nature',
      'PowerofFlower',
      'Just Feel It',
    ];

    return Scaffold(
      body: ListView.builder(
        shrinkWrap: false,
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        itemCount: 4, // Ensure itemCount matches the length of texts or images
        cacheExtent: size.height * 3, // Cache images for smooth scrolling
        itemBuilder: (context, index) {
          return Container(
            height: size.height,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(),
            child: Stack(
              children: [
                Container(
                  transform: Matrix4.identity()
                    ..translate(
                        0.0,
                        scrollController.hasClients
                            ? (-(index * size.height) +
                                    scrollController.position.pixels) /
                                2
                            : 1.0), // tính toán chiều dọc thay đổi của prallax effect

                  width: size.width,
                  height: size.height,
                  child: Image.asset(
                    'assets/images/image${index + 1}.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        PhotoViewIndex(index: index);
                      },
                      child: Text(
                        texts[index].toUpperCase(),
                        style: GoogleFonts.sanchez(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.white54),
                      ),
                    ),
                  ).asGlass(clipBorderRadius: BorderRadius.circular(23)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PhotoViewIndex extends StatelessWidget {
  const PhotoViewIndex({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: PhotoView(
          imageProvider: AssetImage(
            'assets/images/image${index + 1}.jpg',
          ),
        ),
      ),
    );
  }
}
