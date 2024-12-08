import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _age = 25;
  String _gender = "Male";
  double _bmi = 0.0;
  String _bmiCategory = "Unknown";
  String _bmiSuggestion = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.teal.shade50,
      appBar: AppBar(
        title: const Text(
          "BMI Calculator",
          style: TextStyle(
            fontFamily: 'Schyler',
            fontWeight: FontWeight.bold,
            fontSize: 40,
            color: Colors.orangeAccent
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Top Container for Output
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade300, Colors.teal.shade600],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Your BMI",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _bmi == 0.0 ? "--" : _bmi.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      _bmiCategory,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _bmiSuggestion,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Gender Selection
              _heading("Select Gender"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _genderSelectionButton("Male"),
                  const SizedBox(width: 20),
                  _genderSelectionButton("Female"),
                ],
              ),
              const SizedBox(height: 20),

              // Height Input
              _heading("Height (cm)"),
              TextField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter your height in cm",
                  prefixIcon: Icon(Icons.height),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Weight Input
              _heading("Weight (kg)"),
              TextField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Enter your weight in kg",
                  prefixIcon: Icon(Icons.monitor_weight),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Age Slider
              _heading("Age"),
              Slider(
                value: _age,
                min: 10,
                max: 100,
                divisions: 90,
                label: _age.toInt().toString(),
                activeColor: Colors.teal,
                onChanged: (value) {
                  setState(() {
                    _age = value;
                  });
                },
              ),
              Text(
                "${_age.toInt()} years",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Calculate Button
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _calculateBMI();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Calculate BMI",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.amberAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _heading(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _genderSelectionButton(String gender) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _gender = gender;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: _gender == gender ? Colors.teal : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          gender,
          style: TextStyle(
            color: _gender == gender ? Colors.white : Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _calculateBMI() {
    if (_heightController.text.isNotEmpty &&
        _weightController.text.isNotEmpty) {
      double height = double.parse(_heightController.text) / 100;
      double weight = double.parse(_weightController.text);
      _bmi = weight / (height * height);

      if (_bmi < 18.5) {
        _bmiCategory = "Underweight";
        _bmiSuggestion = "You may need to gain weight. Consider a balanced diet.";
      } else if (_bmi < 24.9) {
        _bmiCategory = "Normal";
        _bmiSuggestion = "Great! Keep maintaining a healthy lifestyle.";
      } else if (_bmi < 29.9) {
        _bmiCategory = "Overweight";
        _bmiSuggestion = "You may need to lose weight. Regular exercise can help.";
      } else {
        _bmiCategory = "Obese";
        _bmiSuggestion = "You should consult a healthcare professional.";
      }
    }
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: BMICalculator(),
  ));
}
