import 'package:pie_menu/pie_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StylingPage extends StatelessWidget {
  const StylingPage({Key? key}) : super(key: key);

  static const double spacing = 20;
  final _pageTheme = const PieTheme(
    delayDuration: Duration.zero,
  );

  @override
  Widget build(BuildContext context) {
    return PieCanvas(
      theme: _pageTheme,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(spacing),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    buildBasicUsage(context),
                    const SizedBox(height: spacing),
                    buildDarkMode(context),
                  ],
                ),
              ),
              const SizedBox(width: spacing),
              Expanded(
                child: Column(
                  children: [
                    buildLargeActions(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard({
    Color? color,
    required IconData iconData,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Icon(
          iconData,
          color: Colors.white,
          size: 64,
        ),
      ),
    );
  }

  Widget buildBasicUsage(BuildContext context) {
    return Expanded(
      child: PieMenu(
        actions: [
          PieAction(
            tooltip: 'Play',
            iconData: CupertinoIcons.play_fill,
            onSelect: () => showSnackBar('Play', context),
            // For optical correction purposes
            padding: const EdgeInsets.only(left: 4),
          ),
          PieAction(
            tooltip: 'Download',
            iconData: CupertinoIcons.floppy_disk,
            onSelect: () => showSnackBar('Download', context),
          ),
          PieAction(
            tooltip: 'Share',
            iconData: Icons.share,
            onSelect: () => showSnackBar('Share', context),
          ),
        ],
        child: buildCard(
          color: Colors.deepOrangeAccent,
          iconData: CupertinoIcons.video_camera_solid,
        ),
      ),
    );
  }

  Widget buildDarkMode(BuildContext context) {
    return Expanded(
      child: PieMenu(
        theme: _pageTheme.copyWith(
          buttonTheme: const PieButtonTheme(actionColor: Colors.deepOrange),
          hoveredButtonTheme: const PieButtonTheme.hovered(
            actionColor: Colors.orange,
          ),
          brightness: Brightness.dark,
        ),
        actions: [
          PieAction(
            tooltip: 'how',
            onSelect: () => showSnackBar('1', context),
            customWidget: buildTextButton('1', false),
            customHoveredWidget: buildTextButton('1', true),
          ),
          PieAction(
            tooltip: 'cool',
            onSelect: () => showSnackBar('2', context),
            customWidget: buildTextButton('2', false),
            customHoveredWidget: buildTextButton('2', true),
          ),
          PieAction(
            tooltip: 'is',
            onSelect: () => showSnackBar('3', context),
            customWidget: buildTextButton('3', false),
            customHoveredWidget: buildTextButton('3', true),
          ),
          PieAction(
            tooltip: 'this?!',
            onSelect: () => showSnackBar('Pretty cool :)', context),
            customWidget: buildTextButton('4', false),
            customHoveredWidget: buildTextButton('4', true),
          ),
        ],
        child: buildCard(
          color: Colors.deepPurple,
          iconData: CupertinoIcons.moon_fill,
        ),
      ),
    );
  }

  Widget buildTextButton(String text, bool hovered) {
    return Text(
      text,
      style: TextStyle(
        color: hovered ? Colors.black : Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildLargeActions(BuildContext context) {
    return Expanded(
      child: PieMenu(
        theme: _pageTheme.copyWith(
          brightness: Brightness.dark,
          overlayColor: Colors.green.withOpacity(0.7),
          buttonTheme: const PieButtonTheme(actionColor: Colors.red),
          hoveredButtonTheme: const PieButtonTheme.hovered(
            actionColor: Colors.white,
          ),
          buttonSize: 84,
        ),
        actions: [
          PieAction(
            tooltip: 'Like the package',
            iconData: Icons.thumb_up,
            onSelect: () {},
          ),
          PieAction(
            tooltip: 'Import to your app',
            iconData: Icons.scatter_plot,
            // Custom icon size
            iconSize: 32,
            // Custom background color
            color: Colors.red[700],
            onSelect: () {},
          ),
          PieAction(
            tooltip: 'Leave a feedback',
            iconData: CupertinoIcons.chat_bubble_text_fill,
            color: Colors.red[900],
            onSelect: () {},
          ),
        ],
        child: buildCard(
          color: Colors.blue,
          iconData: CupertinoIcons.zoom_in,
        ),
      ),
    );
  }

  void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
