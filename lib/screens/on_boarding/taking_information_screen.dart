import 'package:flutter/material.dart';
import 'package:bachmeal/core/theme.dart';
import 'package:geolocator/geolocator.dart';

class TakingInformationScreen extends StatefulWidget {
  @override
  _TakingInformationScreenState createState() =>
      _TakingInformationScreenState();
}

class _TakingInformationScreenState extends State<TakingInformationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();
  final TextEditingController _floorController = TextEditingController();
  bool _acceptTerms = false;

  String? _selectedReligion;
  String? _selectedGender;
  String? _selectedProfession;
  List<String> dietaryPreferences = [];

  final List<String> religions = [
    "Islam",
    "Hinduism",
    "Christianity",
    "Buddhism",
    "Other"
  ];
  final List<String> genders = ["Male", "Female", "Other"];
  final List<String> professions = ["Employee", "Student", "Other"];
  final List<String> dietaryOptions = [
    "Vegetarian",
    "Non-Vegetarian",
    "Spicy Food",
    "Avoid Beef"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Essential Information"),
        backgroundColor: AppTheme.gold,
      ),
      backgroundColor: AppTheme.offWhite,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Personal Information"),
              Row(
                children: [
                  Expanded(
                      child: _buildTextField("First Name", _firstNameController,
                          Icons.person, "Enter your first name")),
                  const SizedBox(width: 10),
                  Expanded(
                      child: _buildTextField("Last Name", _lastNameController,
                          Icons.person, "Enter your last name")),
                ],
              ),
              _buildPhoneNumberField(),
              _buildSectionTitle("Delivery Address"),
              _buildLocationField(),
              _buildTextField("Landmark (Optional)", _landmarkController,
                  Icons.home, "e.g., Near Market"),
              _buildTextField("Floor/Apartment Level (Optional)",
                  _floorController, Icons.apartment, "e.g., 3rd Floor"),
              _buildSectionTitle("Additional Information"),
              _buildDropdown("Religion", _selectedReligion, religions, (value) {
                setState(() => _selectedReligion = value);
              }),
              _buildDropdown("Gender", _selectedGender, genders, (value) {
                setState(() => _selectedGender = value);
              }),
              _buildDropdown("Profession", _selectedProfession, professions,
                  (value) {
                setState(() => _selectedProfession = value);
              }),
              _buildMultiSelect("Dietary Preferences (Optional)",
                  dietaryPreferences, dietaryOptions),
              _buildTermsAndConditions(),
              const SizedBox(height: 20),
              _buildConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: AppTheme.textTheme.displaySmall
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      IconData icon, String hint) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: AppTheme.darkGray),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) {
          if (label != "Landmark (Optional)" &&
              label != "Floor/Apartment Level (Optional)" &&
              (value == null || value.isEmpty)) {
            return "This field is required";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return _buildTextField(
        "Phone Number", _phoneController, Icons.phone, "+88XXXXXXXXXX");
  }

  Widget _buildDropdown(String label, String? selectedValue,
      List<String> options, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white,
        ),
        items: options.map((value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
        validator: (value) {
          if (value == null) return "Please select $label";
          return null;
        },
      ),
    );
  }

  Widget _buildMultiSelect(
      String label, List<String> selectedValues, List<String> options) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTheme.textTheme.bodyLarge),
          Wrap(
            spacing: 8,
            children: options.map((option) {
              bool isSelected = selectedValues.contains(option);
              return ChoiceChip(
                label: Text(option),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    selected
                        ? selectedValues.add(option)
                        : selectedValues.remove(option);
                  });
                },
                selectedColor: AppTheme.lavender,
                backgroundColor: Colors.white,
                labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppTheme.darkGray),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationField() {
    return Row(
      children: [
        Expanded(
          child: _buildTextField("Set Delivery Address", _addressController,
              Icons.location_on, "Enter your address"),
        ),
        IconButton(
          icon: const Icon(Icons.gps_fixed, color: AppTheme.gold),
          onPressed: _getCurrentLocation,
        ),
      ],
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location services are disabled.")));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location permission denied.")));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Location permissions are permanently denied.")));
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _addressController.text =
        "Lat: ${position.latitude}, Lng: ${position.longitude}";
  }

  Widget _buildTermsAndConditions() {
    return Row(
      children: [
        Checkbox(
            value: _acceptTerms,
            onChanged: (value) => setState(() => _acceptTerms = value!)),
        Expanded(
            child: Text("I accept the Terms & Conditions",
                style: AppTheme.textTheme.bodyMedium)),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate() && _acceptTerms) {
          // Proceed with signup logic
        }
      },
      child: const Text("Confirm & Proceed"),
    );
  }
}
