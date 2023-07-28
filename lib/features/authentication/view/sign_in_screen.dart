import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/common/widgets/scircle_button.dart';
import 'package:todo_app/core/common/widgets/scircle_widget.dart';
import 'package:todo_app/core/common/widgets/white_space.dart';
import 'package:todo_app/core/res/colurs.dart';
import 'package:todo_app/core/res/media_res.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/features/authentication/app/country_code_provider.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final code = ref.watch(countryCodeProvider);
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          physics: const PageScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          children: [
            Image.asset(MediaRes.todo),
            WhiteSpace(
              height: 20,
            ),
            Text(
              "Please enter your mobile number to get verification code.",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: AppColurs.light,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            WhiteSpace(
              height: 20,
            ),
            SCircleWidget(
              height: 50,
              width: 200,
              color: AppColurs.light,
              wid: TextField(
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: false, signed: false),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                ],
                cursorColor: AppColurs.darkBackground,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  prefix: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        onSelect: (country) {
                          ref
                              .read(countryCodeProvider.notifier)
                              .changeCountry(country);
                        },
                        useSafeArea: true,
                        showPhoneCode: true,
                        countryListTheme: CountryListThemeData(
                            bottomSheetHeight:
                                MediaQuery.of(context).size.height * 0.6,
                            backgroundColor: AppColurs.darkBackground,
                            textStyle: GoogleFonts.poppins(
                              color: AppColurs.light,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                            inputDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              label: Text("Search"),
                              labelStyle: GoogleFonts.poppins(
                                color: AppColurs.light,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      );
                    },
                    child: Text(
                      code == null
                          ? "Pick a country"
                          : "${code.flagEmoji}${code.countryCode}",
                      style: GoogleFonts.poppins(
                        fontSize: code == null ? 13 : 18,
                        color: AppColurs.darkBackground,
                        fontWeight:
                            code == null ? FontWeight.w500 : FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: AppColurs.darkBackground,
                    fontWeight: FontWeight.bold),
              ),
            ),
            WhiteSpace(
              height: 25,
            ),
            SCircleButton(
              onPressed: () {
                // AuthenticationController().sendOTP(context: context, phoneNumber: "phoneNumber");
              },
              text: "Send Code",
              width: 10,
              height: 50,
              fontWeight: FontWeight.w700,
              textColor: AppColurs.darkBackground,
              fontSize: 15,
              bgColor: AppColurs.light,
            ),
          ],
        ),
      ),
    );
  }
}