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

4、VMware虚拟机Mac OS X无法调整扩展硬盘大小，更新xcode时出现磁盘空间不足。
MacOSX有一个diskutil命令（在终端里面使用）。而diskutil有一个resizeVolume命令。
1）打开终端，输入diskutil list
2）.从显示的列表中找到你需要扩展的分区，如上图。我的磁盘有107.4G，但系统分区为42.1GB。（分区的ID一般为diskXsX，我的ID是disk0s2）；
3）.然后输入 diskutil resizeVolume disk0s2 100GB，其中disk0s2为对应分区的ID，100GB为目标大小（这里的目标大小不能超过这个磁盘的总额）；回车，等待完成就可以使用了。
from https://www.cnblogs.com/atree/p/MacOSX_diskutil_xcode.html

5、flutter 打包apk之后，安装在手机上无法访问网络：
android/src/main/AndroidManifest.xml使用权限申请配置放到这里 打包再次安装 就可以访问网路了，权限如下：
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />

6、ios端面，flutter与原生交互时，会出现x86_64 找不到的，百度后为对自己的没用，最后终极解决方案是，拿一个可以跑的flutter项目，把项目的ios目录删除，再使用新的可能跑的ios覆盖过来，再把代码移过来就可以了使用。

7、升级Android Studio 3.5遇到一些坑：flutter、dart插件不兼容，需要手动到 https://plugins.jetbrains.com/androidstudio 下载对应版本才能兼容。版本具体如下：
[√] Flutter (Channel stable, v1.7.8+hotfix.4, on Microsoft Windows [Version 10.0.17134.320], locale zh-CN)
    • Flutter version 1.7.8+hotfix.4 at C:\flutter
    • Framework revision 20e59316b8 (6 weeks ago), 2019-07-18 20:04:33 -0700
    • Engine revision fee001c93f
    • Dart version 2.4.0
[√] Android toolchain - develop for Android devices (Android SDK version 29.0.1)
    • Android SDK at C:\Users\jinpang\AppData\Local\Android\Sdk
    • Android NDK location not configured (optional; useful for native profiling support)
    • Platform android-29, build-tools 29.0.1
    • ANDROID_HOME = C:\Users\jinpang\AppData\Local\Android\Sdk
    • Java binary at: C:\Program Files\Android\Android Studio\jre\bin\java
    • Java version OpenJDK Runtime Environment (build 1.8.0_202-release-1483-b03)
    • All Android licenses accepted.
[√] Android Studio (version 3.5)
    • Android Studio at C:\Program Files\Android\Android Studio
    • Flutter plugin version 38.2.3
    • Dart plugin version 191.8405
    • Java version OpenJDK Runtime Environment (build 1.8.0_202-release-1483-b03)
