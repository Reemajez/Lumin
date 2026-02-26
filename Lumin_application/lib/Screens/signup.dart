import 'package:flutter/material.dart';
import 'package:lumin_application/Screens/login.dart';
import '../theme/app_colors.dart';
import '../Widgets/gradient_background.dart';

// ✅ NEW
import 'package:intl_phone_field/intl_phone_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  String _energySource = 'Grid + Solar';
  bool _hasSolarPanels = true;

  // ✅ (اختياري) نخزن الرقم النهائي هنا لو احتجتيه لاحقًا
  String _fullPhone = '';

  static const double _gap12 = 12;
  static const double _gap16 = 20; // ✅ (التعديل الأول) كانت 16
  static const double _gap18 = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),

                /// ✅ Logo (كبرناه)
                Center(
                  child: Image.asset(
                    'assets/images/Lumin_logo.png',
                    height: 105,
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 18),

                /// Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.white.withOpacity(0.06)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create account',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),

                      Row(
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                          GestureDetector(
                            // ✅ (التعديل الثاني) يودّي لصفحة Login
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const LoginPage()),
                              );
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: AppColors.button,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: _gap18),

                      // Username
                      _field(
                        TextField(
                          style: const TextStyle(
                            color: Colors.white, // ✅ النص أبيض
                            fontWeight: FontWeight.w600,
                          ),
                          cursorColor: Colors.white, // ✅ المؤشر أبيض
                          decoration: InputDecoration(
                            hintText: 'Username',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                        ),
                      ),
                      const SizedBox(height: _gap16),

                      // Email
                      _field(
                        TextField(
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Email address',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                        ),
                      ),
                      const SizedBox(height: _gap16),

                      // ✅✅✅ Phone field (flag + country code)
                      _field(
                        IntlPhoneField(
                          initialCountryCode: 'SA',
                          disableLengthCheck: true,
                          cursorColor: Colors.white, // ✅ خليته أبيض
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          dropdownTextStyle: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          dropdownIcon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white.withOpacity(0.6),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Phone number',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                            prefixIcon: const Icon(Icons.phone_outlined),
                          ),
                          onChanged: (phone) {
                            _fullPhone = phone.completeNumber;
                          },
                        ),
                      ),
                      const SizedBox(height: _gap16),

                      /// 🔐 Password
                      _field(
                        TextField(
                          obscureText: _obscurePassword,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  setState(() => _obscurePassword = !_obscurePassword),
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: _obscurePassword ? Colors.white54 : AppColors.button,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: _gap16),

                      /// 🔐 Confirm Password
                      _field(
                        TextField(
                          obscureText: _obscureConfirmPassword,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: 'Confirm password',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: () => setState(
                                  () => _obscureConfirmPassword = !_obscureConfirmPassword),
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: _obscureConfirmPassword ? Colors.white54 : AppColors.button,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: _gap18),

                      const Text(
                        'Energy Source Type',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: _gap12),

                      _buildEnergyOption('Grid only'),
                      const SizedBox(height: 10),
                      _buildEnergyOption('Grid + Solar'),

                      const SizedBox(height: _gap18),

                      /// ✅ يظهر فقط لو Grid + Solar
                      if (_energySource == 'Grid + Solar') ...[
                        _buildSolarPanelSelection(),
                        const SizedBox(height: _gap18),
                      ],

                      /// ✅ Button من AppTheme
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text(
                            'Create Account',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(Widget child) => SizedBox(height: 50, child: child);

  Widget _buildEnergyOption(String title) {
    final bool isSelected = _energySource == title;

    return GestureDetector(
      onTap: () => setState(() => _energySource = title),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.button.withOpacity(0.22) : Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.button : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected ? AppColors.button : Colors.white.withOpacity(0.45),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSolarPanelSelection() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Do you have solar panels installed?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _hasSolarPanels = true),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: _hasSolarPanels ? AppColors.button : Colors.white.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _hasSolarPanels = false),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: !_hasSolarPanels ? AppColors.button : Colors.white.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'No',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Enables solar monitoring and predictions.',
            style: TextStyle(
              color: Colors.white.withOpacity(0.45),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}