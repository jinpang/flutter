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
