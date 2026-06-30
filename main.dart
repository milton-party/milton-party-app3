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
      title: 'Apple Live App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFFE91E63), // পিংক বা লাভার থিম (লাইভ অ্যাপের মতো)
        scaffoldBackgroundColor: const Color(0xFF0B071E),
      ),
      home: const LoginScreen(),
    );
  }
}

// ---- ১. সুন্দর লোগো ও লগইন স্ক্রিন ----
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
                // প্রিমিয়াম লাইভ লোগো
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(colors: [Colors.pink, Colors.purple]),
                    boxShadow: [BoxShadow(color: Colors.pink.withOpacity(0.5), blurRadius: 20)],
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
                      elevation: 5,
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

// ---- ২. ড্যাশবোর্ড ও লাইভ রুম প্রিভিউ ----
class MainDashboard extends StatefulWidget {
  final String role;
  final String userId;

  const MainDashboard({super.key, required this.role, required this.userId});

  @override
  State<MainDashboard> createState() => _MainDashboardState();
}

class _HomeScreenState extends State<MainDashboard> {} // Dummy state reference fix

class _MainDashboardState extends State<MainDashboard> {
  double ownerComm = 25.0;
  double adminComm = 15.0;
  double bdComm = 10.0;
  double agencyComm = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.role} ড্যাশবোর্ড', style: const TextStyle(fontSize: 16)),
        backgroundColor: const Color(0xFF120B2C),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Chip(
              avatar: const Icon(Icons.diamond, color: Colors.amber, size: 16),
              label: const Text('১০,০০,০০০', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.black38,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // কমিশন সেটিং এরিয়া (হায়ারার্কি ভিউ)
            const Text('📊 লাইভ কমিশন নেটওয়ার্ক (%)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pinkAccent)),
            const SizedBox(height: 10),
            Card(
              color: const Color(0xFF1A1235),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    if (widget.role == 'সুপার এডমিন (আপনি)')
                      _buildCommRow('ওনার প্রফিট (আপনার)', ownerComm, Colors.purple, true),
                    if (widget.role == 'সুপার এডমিন (আপনি)' || widget.role == 'এডমিন')
                      _buildCommRow('এডমিন পার্সেন্টেজ', adminComm, Colors.red, widget.role == 'সুপার এডমিন (আপনি)'),
                    if (widget.role != 'এজেন্সি')
                      _buildCommRow('বিডি (BD) পার্সেন্টেজ', bdComm, Colors.blue, widget.role == 'সুপার এডমিন (আপনি)'),
                    _buildCommRow('এজেন্সি পার্সেন্টেজ', agencyComm, Colors.green, widget.role == 'সুপার এডমিন (আপনি)'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),

            // লাইভ রুম ডেমো সেকশন
            const Text('🎤 একটিভ ভয়েস পার্টি রুমস (Live)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.amber)),
            const SizedBox(height: 12),
            
            // রিয়েল লাইভ রুমের মতো ডিজাইন কার্ড
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const VoiceRoomScreen()));
              },
              child: Container(
                height: 120,
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
                          SizedBox(height: 5),
                          Row(children: [Icon(Icons.headset, size: 14), Text(' ৪২ জন লাইভে শুনছেন')]),
                        ],
                      ),
                      Icon(Icons.play_circle_fill, size: 45, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),
            
            // অন্যান্য মেনু গ্রিড
            const Text('এজেন্ট ও অ্যাকাউন্ট সেটিংস', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildMenuCard(Icons.wallet, 'এজেন্ট রিচার্জ প্যানেল', Colors.teal),
                _buildMenuCard(Icons.verified, 'KYC আইডি কার্ড সাবমিট', Colors.orange),
                _buildMenuCard(Icons.people, 'আপনার মেম্বার লিস্ট', Colors.indigo),
                _buildMenuCard(Icons.analytics, 'টোটাল কমিশন রিপোর্ট', Colors.blueGrey),
              ],
            )
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
          Text(label, style: const TextStyle(fontSize: 14)),
          Row(
            children: [
              Text('$val%', style: TextStyle(fontWeight: FontWeight.bold, color: col, fontSize: 16)),
              if (editable) const Icon(Icons.arrow_drop_down, color: Colors.white54)
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMenuCard(IconData icon, String title, Color col) {
    return Card(
      color: const Color(0xFF171030),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: col),
          const SizedBox(height: 10),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

// ---- ৩. প্লে-স্টোরের মতো লাইভ ভয়েস রুম ইন্টারফেস ----
class VoiceRoomScreen extends StatelessWidget {
  const VoiceRoomScreen({super.key});

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
              // রুমের ওপরের বার
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context)),
                    const Column(
                      children: [
                        Text('ঢাকাইয়া মাস্তী আড্ডা রুম', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text('অনলাইন: ১২৫', style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
                      ],
                    ),
                    const CircleAvatar(backgroundColor: Colors.pink, child: Icon(Icons.share, size: 18)),
                  ],
                ),
              ),
              const Spacer(),
              
              // ভয়েস রুমের ৮টি সীট লেআউট (মিহো বা অ্যাপল লাইভের মতো)
              const Text('🎙️ স্টেজ সীটস', style: TextStyle(color: Colors.white54)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: List.generate(8, (index) {
                    if (index == 0) {
                      return const Column(
                        children: [
                          CircleAvatar(radius: 24, backgroundColor: Colors.amber, child: Icon(Icons.star, color: Colors.black)),
                          SizedBox(height: 4),
                          Text('হোস্ট', style: TextStyle(fontSize: 10, color: Colors.amber)),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        CircleAvatar(radius: 24, backgroundColor: Colors.black45, child: Icon(Icons.mic_off, size: 18, color: Colors.white30)),
                        const SizedBox(height: 4),
                        Text('${index + 1} নং সীট', style: const TextStyle(fontSize: 10, color: Colors.white54)),
                      ],
                    );
                  }),
                ),
              ),
              const Spacer(),
              
              // নিচের গিফটিং বার ও কমেন্ট সেকশন
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.black45,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(20)),
                        child: const Text('পাবলিক কমেন্ট লিখুন...', style: TextStyle(color: Colors.white38)),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // গিফট বাটন
                    GestureDetector(
                      onTap: () {
                        // গিফট বক্স ওপেন করার ডেমো পপআপ
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: const Color(0xFF1A1235),
                          builder: (context) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('🎁 গিফট গ্যালারি স্টোর', style: TextStyle(fontSize: 18, color: Colors.amber, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(children: [Icon(Icons.card_giftcard, size: 40, color: Colors.pink), Text('রোজ (১০ কয়েন)')]),
                                      Column(children: [Icon(Icons.star, size: 40, color: Colors.amber), Text('মুকুট (৫০০ কয়েন)')]),
                                      Column(children: [Icon(Icons.directions_car, size: 40, color: Colors.blue), Text('কার (২০০০ কয়েন)')]),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
                        child: const Icon(Icons.card_giftcard, color: Colors.white),
                      ),
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
