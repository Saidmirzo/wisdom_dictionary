import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:jbaza/jbaza.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:translator/translator.dart';
import '../../../widgets/loading_widget.dart';

class GoogleTranslatorPageViewModel extends BaseViewModel {
  GoogleTranslatorPageViewModel({required super.context});
  final translator = GoogleTranslator();

  FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;
  bool isListening = false;

  Future? dialog;

  Future<String> translate(String text) async {
    var translated = "";
    if (text.isNotEmpty) {
      setBusy(true);
      checkNetwork();
      translated = await translator.translate(text, from: "uz", to: "en").then((value) => value.text);
    }
    setSuccess();
    return translated;
  }

  Future<void> readText(String text) async {
    if (isSpeaking) {
      flutterTts.stop();
    } else {
      await flutterTts.setLanguage("en-US");
      await flutterTts.speak(text);
    }
  }

  Future<String> voiceToText() async {
    String resultText = "";
    Duration duration = const Duration(seconds: 5);
    SpeechToText speech = SpeechToText();
    bool available = await speech.initialize();
    if (available) {
      await speech.listen(
        listenFor: duration,
        onResult: (result) {
          resultText = result.recognizedWords;
        },
      );
    } else {
      log("The user has denied the use of speech recognition.");
    }
    await Future.delayed(duration);
    return resultText;
  }

  void startListening() {
    isListening = true;
    notifyListeners();
  }

  void stopListening() {
    isListening = false;
    notifyListeners();
  }

  void checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.mobile || connectivityResult != ConnectivityResult.wifi) {
      showTopSnackBar(
        Overlay.of(context!)!,
        const CustomSnackBar.error(message: "Not connected to the Internet"),
      );
      setSuccess();
    }
  }

  @override
  callBackBusy(bool value, String? tag) {
    if (dialog == null && isBusy(tag: tag)) {
      Future.delayed(Duration.zero, () {
        dialog = showLoadingDialog(context!);
      });
    }
  }

  @override
  callBackSuccess(value, String? tag) {
    if (dialog != null) {
      pop();
      dialog = null;
    }
  }

  @override
  callBackError(String text) {
    Future.delayed(Duration.zero, () {
      if (dialog != null) pop();
    });
    showTopSnackBar(
      Overlay.of(context!)!,
      CustomSnackBar.error(
        message: text,
      ),
    );
  }
}
