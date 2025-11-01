import 'package:flutter/material.dart';

class PujasScreen extends StatefulWidget {
  const PujasScreen({super.key});

  @override
  State<PujasScreen> createState() => _PujasScreenState();
}

class _PujasScreenState extends State<PujasScreen> {
  final Map<String, bool> _pujaStates = {
    'Ganesh Puja': true,
    'Griha Puja': false,
    'Annaprasana Puja': false,
    'Satyanarayan Puja': true,
    'Horoscope': false,
    'Paachang': false,
  };

  final Map<String, String> _pujaPrices = {
    'Ganesh Puja': '₹1500',
    'Griha Puja': '₹1500',
    'Annaprasana Puja': '₹1500',
    'Satyanarayan Puja': '₹1500',
    'Horoscope': '₹1500',
    'Paachang': '₹1500',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        onPressed: _showAddPujaBottomSheet,
        backgroundColor: const Color(0xFFE47F25),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Puja Services',
          style: TextStyle(
            color: Color(0xFFE47F25),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Color(0xFFE47F25), size: 20),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Search Puja',
                      style: TextStyle(color: Color(0xFF000000), fontSize: 14),
                    ),
                  ),

                  // Icon(
                  //   Icons.vertical_align_bottom_sharp,
                  //   color: Color(0xFFFF9800),
                  //   size: 20,
                  // ),
                  // SizedBox(width: 12),
                  // Icon(Icons.more_vert, color: Colors.grey, size: 16),
                  Container(
                    width: 1,
                    height: 40,
                    color: Color(0xFFE47F25).withOpacity(0.5),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.mic, color: Color(0xFFE47F25), size: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Puja List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: _pujaStates.length,
                itemBuilder: (context, index) {
                  final pujaName = _pujaStates.keys.elementAt(index);
                  return _buildPujaServiceCard(pujaName);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPujaServiceCard(String pujaName) {
    final isActive = _pujaStates[pujaName] ?? false;
    final price = _pujaPrices[pujaName] ?? '₹1500';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE47F25)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFE47F25).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              // border: Border.all(
              //   color: const Color(0xFFFF9800).withOpacity(0.3),
              // ),
            ),
            // child: const Icon(
            //   Icons.temple_hindu,
            //   color: Color(0xFFE47F25),
            //   size: 20,
            // ),
            child: Image.asset('assets/images/oom.jpg', width: 24, height: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pujaName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF000000),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _showEditPujaDialog(pujaName),
                      child: const Icon(
                        Icons.edit,
                        size: 16,
                        color: Color(0xFFE47F25),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Switch(
            value: isActive,
            onChanged: (value) {
              setState(() {
                _pujaStates[pujaName] = value;
              });
            },
            activeColor: const Color(0xFFE47F25),

            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  void _showAddPujaBottomSheet() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add Puja',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Puja Name',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter Puja Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE47F25)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'New Price',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter amount',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFFE47F25)),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      priceController.text.isNotEmpty) {
                    setState(() {
                      _pujaStates[nameController.text] = false;
                      _pujaPrices[nameController.text] =
                          '₹${priceController.text}';
                    });
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE47F25),
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditPujaDialog(String pujaName) {
    final TextEditingController nameController = TextEditingController(
      text: pujaName,
    );
    final TextEditingController priceController = TextEditingController(
      text: (_pujaPrices[pujaName] ?? '₹1500').replaceAll('₹', ''),
    );

    showDialog(
      context: context,
      // barrierColor: Colors.black26,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Edit Puja Price',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Puja Name',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE47F25)),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'New Price',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE47F25)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        priceController.text.isNotEmpty) {
                      setState(() {
                        // Remove old entry if name changed
                        if (nameController.text != pujaName) {
                          _pujaStates.remove(pujaName);
                          _pujaPrices.remove(pujaName);
                        }
                        // Add/update with new values
                        _pujaStates[nameController.text] =
                            _pujaStates[pujaName] ?? false;
                        _pujaPrices[nameController.text] =
                            '₹${priceController.text}';
                      });
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE47F25),
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
