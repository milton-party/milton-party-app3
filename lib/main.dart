import 'package:flutter/material.dart';

void main() {
  runApp(const AppleLiveApp());
}

class AppleLiveApp extends StatelessWidget {
  const AppleLiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apple Live Production',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFE91E63),
        scaffoldBackgroundColor: const Color(0xFF0B071E),
      ),
      home: const LoginScreen(),
    );
  }
}

// ---- ১. প্রফেশনাল লগইন প্যানেল ----
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedRole = 'সুপার এডমিন (আপনি)';
  final TextEditingController _idController = TextEditingController(text: 'milton_boss');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0B071E), Color(0xFF1F0D3D)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [Colors.pink, Colors.purple]),
                  ),
                  child: const Icon(Icons.live_tv, size: 50, color: Colors.white),
                ),
                const SizedBox(height: 20),
                const Text(
                  'APPLE LIVE',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 3),
                ),
                const Text('ভয়েস আড্ডা ও রিয়েল-টাইম আর্নিং', style: TextStyle(color: Colors.pinkAccent, fontWeight: FontWeight.w500)),
                const SizedBox(height: 40),
                TextField(
                  controller: _idController,
                  decoration: InputDecoration(
                    labelText: 'ইউজার আইডি বা ফোন নম্বর',
                    prefixIcon: const Icon(Icons.phone_android, color: Colors.pinkAccent),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    backgroundColor: const Color(0xFF171030),
                  ),
                  items: <String>['সুপার এডমিন (আপনি)', 'এডমিন', 'বিডি (BD)', 'এজেন্সি'].map((String value) {
                    return DropdownMenuItem<String>(value: value, child: Text(value));
                  }).toList(),
                  onChanged: (value) => setState(() => selectedRole = value!),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainDashboard(role: selectedRole, userId: _idController.text),
                        ),
                      );
                    },
                    child: const Text('লগইন করুন', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---- ২. ড্যাশবোর্ড ও কমিশন কন্ট্রোলার ----
class MainDashboard extends StatefulWidget {
  final String role;
  final String userId;
  const MainDashboard({super.key, required this.role, required this.userId});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  double ownerComm = 25.0;
  double adminComm = 15.0;
  double bdComm = 10.0;
  double agencyComm = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.role} ড্যাশবোর্ড', style: const TextStyle(fontSize: 14)),
        backgroundColor: const Color(0xFF120B2C),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('📊 লাইভ কমিশন নেটওয়ার্ক (%)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
            const SizedBox(height: 10),
            Card(
              color: const Color(0xFF1A1235),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    if (widget.role == 'সুপার এডমিন (আপনি)') _buildCommRow('ওনার প্রফিট (আপনার)', ownerComm, Colors.purple, true),
                    if (widget.role == 'সুপার এডমিন (আপনি)' || widget.role == 'এডমিন') _buildCommRow('এডমিন পার্সেন্টেজ', adminComm, Colors.red, widget.role == 'সুপার এডমিন (আপনি)'),
                    if (widget.role != 'এজেন্সি') _buildCommRow('বিডি (BD) পার্সেন্টেজ', bdComm, Colors.blue, widget.role == 'সুপার এডমিন (আপনি)'),
                    _buildCommRow('এজেন্সি পার্সেন্টেজ', agencyComm, Colors.green, widget.role == 'সুপার এডমিন (আপনি)'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text('🎤 একটিভ ভয়েস পার্টিルームস (Live)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const VoiceRoomScreen(roomName: 'ঢাকাইয়া মাস্তী আড্ডা')));
              },
              child: Container(
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: const LinearGradient(colors: [Colors.purple, Colors.pink]),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('🔥 ঢাকাইয়া মাস্তী আড্ডা রুম', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text('ID: 8899220 • হোস্ট: মিল্টন কিং', style: TextStyle(color: Colors.white70)),
                          Text('👥 ৫০+ জন লাইভে আড্ডায় যুক্ত', style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
                        ],
                      ),
                      Icon(Icons.play_circle_fill, size: 45, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommRow(String label, double val, Color col, bool editable) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text('$val%', style: TextStyle(fontWeight: FontWeight.bold, color: col, fontSize: 16)),
        ],
      ),
    );
  }
}

// ---- ৩. ৫০+ মেম্বার ক্যাপাসিটি ভয়েস রুম স্ক্রিন ----
class VoiceRoomScreen extends StatelessWidget {
  final String roomName;
  const VoiceRoomScreen({super.key, required this.roomName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF120524), Color(0xFF330947)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
                    Text(roomName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const CircleAvatar(radius: 18, backgroundColor: Colors.green, child: Text('৫০+', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
                  ],
                ),
              ),
              const Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.mic, size: 80, color: Colors.pinkAccent),
                      SizedBox(height: 20),
                      Text('🎙️ লাইভ অডিও স্টেজ একটিভ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('নিচ থেকে ৫০ জনেরও বেশি অডিয়েন্স ও স্পিকার লাইভ কানেক্ট হতে পারবে।', textAlign: TextAlign.center, style: TextStyle(color: Colors.white60)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.black45,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(20)),
                        child: const Text('আড্ডায় কিছু লিখুন...', style: TextStyle(color: Colors.white38)),
                      ),
                    ),
                    const SizedBox(width: 15),
                    const CircleAvatar(
                      backgroundColor: Colors.pink,
                      child: Icon(Icons.card_giftcard, color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
