import 'package:flutter/material.dart';

void main() {
  runApp(const WalkieTalkieApp());
}

class WalkieTalkieApp extends StatelessWidget {
  const WalkieTalkieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wi-Fi Walkie Talkie',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      home: const DeviceListScreen(),
    );
  }
}

class DeviceListScreen extends StatefulWidget {
  const DeviceListScreen({super.key});

  @override
  State<DeviceListScreen> createState() => _DeviceListScreenState();
}

class _DeviceListScreenState extends State<DeviceListScreen> {
  // فرضی ڈیوائسز کی لسٹ
  List<Map<String, dynamic>> devices = [
    {'name': 'موبائل 1 (Device A)', 'isOnline': true},
    {'name': 'موبائل 2 (Device B)', 'isOnline': false},
    {'name': 'موبائل 3 (Device C)', 'isOnline': true},
  ];

  void toggleStatus(int index) {
    setState(() {
      devices[index]['isOnline'] = !devices[index]['isOnline'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wi-Fi Walkie-Talkie'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Scanned nearby Wi-Fi devices...')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wifi, color: Colors.blueAccent, size: 28),
                SizedBox(width: 10),
                Text(
                  'آس پاس موجود ڈیوائسز',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: devices.length,
              itemBuilder: (context, index) {
                final device = devices[index];
                final bool isOnline = device['isOnline'];

                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  color: const Color(0xFF1E1E2E),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: isOnline ? Colors.green : Colors.red,
                      child: Icon(isOnline ? Icons.power : Icons.power_off, color: Colors.white),
                    ),
                    title: Text(
                      device['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                      isOnline ? 'Online (آن لائن)' : 'Offline (آف لائن)',
                      style: TextStyle(color: isOnline ? Colors.greenAccent : Colors.redAccent),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.call, color: Colors.green),
                          onPressed: isOnline ? () => _showAction(context, "Call", device['name']) : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.message, color: Colors.blue),
                          onPressed: isOnline ? () => _showAction(context, "Message", device['name']) : null,
                        ),
                      ],
                    ),
                    onTap: () => toggleStatus(index), // اسٹیٹس تبدیل کرنے کے لیے
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAction(BuildContext context, String action, String name) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$action initiated for $name')),
    );
  }
