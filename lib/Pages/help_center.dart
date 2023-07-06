import 'package:flutter/material.dart';
import 'package:xwallet/route/routes.dart' as route;

import 'package:xwallet/theme/theme.dart';

class CustomExpansionTile extends StatefulWidget {
  final String title;
  final Widget content;
  final Icon leadingIcon;

  const CustomExpansionTile({
    Key? key,
    required this.title,
    required this.content,
    required this.leadingIcon,
  }) : super(key: key);

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;
  final GlobalKey _expansionTileKey = GlobalKey();
  void _onExpansionChanged(bool expanded) {
    setState(() {
      _isExpanded = expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(
            milliseconds: 400,
          ),
          left: _isExpanded
              ? MediaQuery.of(context).size.width * .78
              : MediaQuery.of(context).size.width * .02,
          top: 15,
          curve: Curves.easeInOut,
          child: GradientIcon(
            icon: widget.leadingIcon,
          ),
        ),
        ExpansionTile(
          key: _expansionTileKey,
          iconColor: Colors.transparent,
          collapsedIconColor: Colors.transparent,
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.end,
          ),
          onExpansionChanged: _onExpansionChanged,
          collapsedBackgroundColor: const Color.fromARGB(45, 255, 255, 255),
          backgroundColor: const Color.fromARGB(111, 20, 20, 20),
          childrenPadding:
              const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          children: [
            widget.content,
          ],
        ),
      ],
    );
  }
}

final List<CustomExpansionTile> expansionTileDataList = [
  const CustomExpansionTile(
    leadingIcon: Icon(Icons.start_rounded),
    title: 'Getting Started',
    content: Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. bi non felis quis augue interdum tincidunt. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum egestas nibh id ligula euismod, sed dapibus odio sollicitudin. Sed eleifend augue nec lectus tincidunt, at aliquam diam feugiatMorbi finibus ipsum elit, viverra hendrerit leo faucibus vel. Sed malesuada sit amet ex in rhoncus. Nam id urna arcu. Nam consectetur gravida cursus. Nunc dignissim lacus sed maximus porttitor. Mauris pharetra, ipsum sit amet congue dapibus,  Mauris in porttitor tortor, quis faucibus lacus.',
    ),
  ),
  const CustomExpansionTile(
    leadingIcon: Icon(Icons.currency_exchange_rounded),
    title: 'How to Make Transactions',
    content: Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. bi non felis quis augue interdum tincidunt. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum egestas nibh id ligula euismod, sed dapibus odio sollicitudin. Sed eleifend augue nec lectus tincidunt, at aliquam diam feugiatMorbi finibus ipsum elit, viverra hendrerit leo faucibus vel. Sed malesuada sit amet ex in rhoncus. Nam id urna arcu. Nam consectetur gravida cursus. Nunc dignissim lacus sed maximus porttitor. Mauris pharetra, ipsum sit amet congue dapibus,  Mauris in porttitor tortor, quis faucibus lacus.',
    ),
  ),
  const CustomExpansionTile(
    leadingIcon: Icon(Icons.security),
    title: 'About Safety and Security',
    content: Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. bi non felis quis augue interdum tincidunt. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum egestas nibh id ligula euismod, sed dapibus odio sollicitudin. Sed eleifend augue nec lectus tincidunt, at aliquam diam feugiatMorbi finibus ipsum elit, viverra hendrerit leo faucibus vel. Sed malesuada sit amet ex in rhoncus. Nam id urna arcu. Nam consectetur gravida cursus. Nunc dignissim lacus sed maximus porttitor. Mauris pharetra, ipsum sit amet congue dapibus,  Mauris in porttitor tortor, quis faucibus lacus.',
    ),
  ),
  const CustomExpansionTile(
    leadingIcon: Icon(Icons.wallet_rounded),
    title: 'Managing Wallet',
    content: Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. bi non felis quis augue interdum tincidunt. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum egestas nibh id ligula euismod, sed dapibus odio sollicitudin. Sed eleifend augue nec lectus tincidunt, at aliquam diam feugiatMorbi finibus ipsum elit, viverra hendrerit leo faucibus vel. Sed malesuada sit amet ex in rhoncus. Nam id urna arcu. Nam consectetur gravida cursus. Nunc dignissim lacus sed maximus porttitor. Mauris pharetra, ipsum sit amet congue dapibus,  Mauris in porttitor tortor, quis faucibus lacus.',
    ),
  ),
];

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 100,
      height: MediaQuery.of(context).size.height * 100,
      decoration: mainTheme(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Help Center'),
          backgroundColor: const Color.fromARGB(86, 9, 1, 40),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
                itemCount: expansionTileDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = expansionTileDataList[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 25),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: gradientBorder(),
                    ),
                    child: Stack(
                      children: [
                        CustomExpansionTile(
                          title: data.title,
                          content: data.content,
                          leadingIcon: data.leadingIcon,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Sub Text
            Padding(
              padding: const EdgeInsets.only(
                bottom: 60,
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  const Text(
                    "Can't find the answers you looking for?",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    child: const Text(
                      'Send a feedback request from here.',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Color.fromARGB(251, 11, 124, 210),
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () =>
                        Navigator.pushNamed(context, route.feedbackPage),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
