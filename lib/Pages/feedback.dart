import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xwallet/theme/theme.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  void onSend() {
    _animationController.forward(from: -1);
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _animation =
        Tween<double>(begin: 0.6, end: -1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  XFile? _imageFile;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: mainTheme(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Give Feedback'),
          backgroundColor: const Color.fromARGB(103, 9, 1, 40),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .07),
          // Robot Image
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/My project-1.png'),
              fit: BoxFit.cover,
              alignment: Alignment(
                MediaQuery.of(context).size.height * .1,
                MediaQuery.of(context).size.width * .5,
              ),
              opacity: 0.6,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    //Page Title
                    "What's the Issue?",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .03,
                  ),
                  Container(
                    // Feedback Input
                    height: MediaQuery.of(context).size.height * .17,
                    width: MediaQuery.of(context).size.width * .80,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(52, 102, 101, 101),
                      borderRadius: BorderRadius.circular(20),
                      border: gradientBorder(),
                    ),

                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      controller: TextEditingController(),
                      maxLines: null,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        //Funny Animated Text
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .67,
                        ),
                        child: ClipRRect(
                          child: Align(
                            widthFactor: 0.14,
                            child: AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(
                                      MediaQuery.of(context).size.width *
                                          _animation.value,
                                      0.9),
                                  child: child,
                                );
                              },
                              child: Text(
                                'Thanks for the feedback human'.toUpperCase(),
                                style: GoogleFonts.getFont(
                                  'Press Start 2P',
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 223, 191, 8),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                  ),
                  Column(
                    //Add Screenhot Button
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .12,
                        height: MediaQuery.of(context).size.height * .055,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(80, 255, 255, 255),
                          border: gradientBorder(),
                        ),
                        child: IconButton(
                          onPressed: _pickImage,
                          icon: const Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 234, 234, 234),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .02,
                      ),
                      const Text(
                        'Add Screenshot',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              const Text(
                'We appriacte all the suggestions we can get from you!',
                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              ElevatedButton(
                //Send button
                onPressed: () {
                  onSend();
                },
                child: const Text('Send'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
