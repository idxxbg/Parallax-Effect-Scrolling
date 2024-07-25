import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parallax_effect_scrolling_flutter/assets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      "Hi",
    ];

    return Scaffold(
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        controller: scrollController,
        itemCount: 4,
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
                    // Assets.image0,
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                  child: Text(
                    texts[index],
                    style: GoogleFonts.sanchez(
                        fontSize: 50, color: Colors.white12),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
