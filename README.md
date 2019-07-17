flutter学习

1、使用Android studio开发Flutter时，记得把Hot Reload打开，才能亚秒级更新UI：File->Settings->Build,Execution,Deployment->Instant Run->勾选Enable Instant Run to hot swap code/resource changes on deploy(default enabled)

2、打包apk：AS->Terminal->flutter build apk
   打包ipa(需要在macOS下进行): AS->Terminal->flutter build ios

3、macOS flutter config:
export PATH=/Users/jinpang/flutter/bin:$PATH
export ANDROID_HOME=/Users/jinpang/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
