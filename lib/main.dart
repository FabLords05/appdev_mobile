import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyProfileApp());
}

class MyProfileApp extends StatefulWidget {
  const MyProfileApp({super.key});

  @override
  State<MyProfileApp> createState() => _MyProfileAppState();
}

class _MyProfileAppState extends State<MyProfileApp> {
  // Theme state
  bool _isDarkMode = true;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: ProfileScreen(onThemeToggle: _toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const ProfileScreen({super.key, required this.onThemeToggle, required this.isDarkMode});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  final Color blue = const Color.fromARGB(255, 77, 155, 103);
  
  late AnimationController _rotationController;
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  void scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = widget.isDarkMode ? Colors.black : Colors.white;
    final textColor = widget.isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: textColor),
            children: [
              TextSpan(text: 'My', style: TextStyle(color: blue)),
              const TextSpan(text: 'Portfolio'),
            ],
          ),
        ),
        actions: [
          _navButton('Home', homeKey, textColor),
          _navButton('About', aboutKey, textColor),
          _navButton('Contacts', contactKey, textColor),
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeToggle,
            color: textColor,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- HOME SECTION ---
            Container(
              key: homeKey,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
              child: Column(
                children: [
                  _buildAnimatedProfileImage(bgColor),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('FABIO JOSEPH M. TUGONON',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textColor)),
                      const SizedBox(height: 8),
                      Text('BSIT Student',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22, color: blue, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text('21 Years Old', style: TextStyle(fontSize: 18, color: textColor)),
                  Text('Lives in Talakag, Philippines', textAlign: TextAlign.center, style: TextStyle(color: textColor)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'I am a dedicated IT student with a strong interest in technology, Linux environments, and system design. I am currently developing a web-based GIS system and always eager to improve my skills through hands-on experience and continuous learning.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(height: 1.6, color: widget.isDarkMode ? Colors.white70 : Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 80), 
                ],
              ),
            ),

            // --- ABOUT SECTION ---
            Container(
              key: aboutKey,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
              child: Column(
                children: [
                  Text('About Me', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: textColor)),
                  const SizedBox(height: 40),
                  _buildTimelineItem(
                    'University of Science and Technology of Southern Philippines', 
                    '(2023 - Present)', 
                    'assets/ustp.png', 
                    'I am presently enrolled here, pursuing a Bachelor of Science in Information Technology and focusing on completing my capstone project.', 
                    bgColor, textColor
                  ),
                  _buildTimelineItem(
                    'Hobbies', 
                    '', 
                    'assets/hobbies.png', 
                    'I enjoy playing Mobile Legends and Arknights: Endfield, watching anime, and studying the Japanese language. I also spend time tweaking my Nyarch Linux setup.', 
                    bgColor, textColor
                  ),
                  _buildTimelineItem(
                    'Projects',
                    '',
                    'assets/linux.png',
                    '• Web-based GIS system using Leaflet.js and Flask\n'
                    '• Nyarch Linux distribution (Arch-based, gaming/multimedia)',
                    bgColor, textColor
                  ),
                ],
              ),
            ),

            // --- CONTACT SECTION (SPLIT LAYOUT) ---
            Container(
              key: contactKey,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 80),
              child: Column(
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 40,
                    runSpacing: 40,
                    children: [
                      // LEFT SIDE
                      SizedBox(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('LOCATION', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2, color: textColor)),
                            const SizedBox(height: 15),
                            Text('Talakag, Philippines', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: widget.isDarkMode ? Colors.white70 : Colors.black87)),
                            const SizedBox(height: 40),
                            Text('FOLLOW ME', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 2, color: textColor)),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _SocialIcon(icon: FontAwesomeIcons.facebookF, color: blue, bgColor: bgColor),
                                _SocialIcon(icon: FontAwesomeIcons.instagram, color: blue, bgColor: bgColor),
                                _SocialIcon(icon: FontAwesomeIcons.github, color: blue, bgColor: bgColor),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // RIGHT SIDE
                      Container(
                        constraints: const BoxConstraints(maxWidth: 450),
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          border: Border.all(color: blue, width: 4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Contact Details', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: blue)),
                            const SizedBox(height: 20),
                            Text('• tugonon.fabiojoseph@gmail.com', style: TextStyle(fontSize: 16, height: 2.0, color: textColor)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100), 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navButton(String text, GlobalKey key, Color textColor) {
    return TextButton(
      onPressed: () => scrollToSection(key),
      child: Text(text, style: TextStyle(color: textColor)),
    );
  }

  Widget _buildAnimatedProfileImage(Color bgColor) {
    // static circular border instead of animated rotation
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 260,
            height: 260,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: blue, width: 4),
            ),
          ),
          Container(
            width: 245,
            height: 245,
            decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
            child: ClipOval(child: Image.asset('assets/fabio.jpg', fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String title, String year, String img, String desc, Color bgColor, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 35),
            padding: const EdgeInsets.fromLTRB(55, 50, 25, 25),
            decoration: BoxDecoration(border: Border.all(color: blue, width: 4), borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
                if (year.isNotEmpty) Text(year, style: TextStyle(fontSize: 16, color: blue, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                // handle multiline description (bulleted) if present
                if (desc.contains('\n'))
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: desc
                        .split('\n')
                        .map((line) => Text(line, style: TextStyle(height: 1.5, color: textColor)))
                        .toList(),
                  )
                else
                  Text(desc, style: TextStyle(height: 1.5, color: textColor)),
              ],
            ),
          ),
          Positioned(
            top: -50,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor, border: Border.all(color: blue, width: 3)),
                child: CircleAvatar(radius: 40, backgroundImage: AssetImage(img), backgroundColor: Colors.transparent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HoverButton extends StatefulWidget {
  final String text;
  final Color blue;
  final Color bgColor;
  final VoidCallback onTap;
  const _HoverButton({required this.text, required this.blue, required this.onTap, required this.bgColor});
  @override
  State<_HoverButton> createState() => _HoverButtonState();
}

class _HoverButtonState extends State<_HoverButton> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          decoration: BoxDecoration(
            color: isHovered ? Colors.transparent : widget.blue,
            borderRadius: BorderRadius.circular(35),
            border: Border.all(color: widget.blue, width: 2),
            boxShadow: isHovered ? [] : [BoxShadow(color: widget.blue.withOpacity(0.5), blurRadius: 10)],
          ),
          child: Text(widget.text, style: TextStyle(color: isHovered ? widget.blue : widget.bgColor, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final Color bgColor;
  const _SocialIcon({required this.icon, required this.color, required this.bgColor});
  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isHovered ? widget.color : Colors.transparent,
          border: Border.all(color: widget.color, width: 2),
        ),
        child: FaIcon(widget.icon, color: isHovered ? widget.bgColor : widget.color, size: 20),
      ),
    );
  }
}