## 移动修改应用图标

### 简介
flutter 修改应用图片(目前只支持iOS)

### 依赖
```
cicon: 
    git: https://github.com/StanleyCocos/cIcon.git
```

### 使用
1. 修改图标
```
Cicon.setIcon(name: "icon2");
```
2. 恢复默认图标
```
Cicon.restoreIcon();
```
3. 获取当前图标名称(Android 不支持获取)
```
Cicon.currentIcon;
```

### iOS配置
环境依赖 #available(iOS 10.3, *)
#### 配置plist
1. 根目录添加(字典类型) CFBundleIcons 
2. CFBundleIcons目录添加(字典类型)CFBundleAlternateIcons
3. CFBundleAlternateIcons 添加你所要设置的icon, 以icon名称为key的字典类型
4. icon字典下添加（数组类型） CFBundleIconFiles, 和(布尔类型) UIPrerenderedIcon 值为FALSE
5. CFBundleIconFiles 添加你所有icon 名称的 item

```
<key>CFBundleIcons</key>
	<dict>
		<key>CFBundleAlternateIcons</key>
		<dict>
			<key>icon2</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>icon20</string>
					<string>icon29</string>
					<string>icon40</string>
					<string>icon60</string>
					<string>icon76</string>
					<string>icon83.5</string>
					<string>icon1024</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
			<key>icon3</key>
			<dict>
				<key>CFBundleIconFiles</key>
				<array>
					<string>hk20</string>
					<string>hk29</string>
					<string>hk40</string>
					<string>hk60</string>
					<string>hk76</string>
					<string>hk83.5</string>
					<string>hk1024</string>
				</array>
				<key>UIPrerenderedIcon</key>
				<false/>
			</dict>
		</dict>
	</dict>
```

### Android配置
> 特别提示：非必要不要使用，目前Flutter不支持切换activity-alias启动

Android在切换图标之后会杀掉APP，Android 9之后会出现，无法兼容。

在 `android/app/src/main/AndroidManifest.xml`  中添加 activity-alias:

```xml
<application
    .......>
  <activity 
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher"
            ......>
  </activity>
  
	<!-- 默认图标，和MainActivity一样，用于恢复图标时使用 -->
  <activity-alias
                  android:name="default"
                  android:enabled="false"
                  android:exported="true"
                  android:label="cicon_example"
                  android:icon="@mipmap/ic_launcher"
                  android:targetActivity=".MainActivity"
                  android:launchMode="singleTop"
                  android:theme="@style/LaunchTheme"
                  android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
                  android:hardwareAccelerated="true"
                  android:windowSoftInputMode="adjustResize">
    <meta-data
               android:name="io.flutter.embedding.android.NormalTheme"
               android:resource="@style/NormalTheme"
               />
    <intent-filter>
      <action android:name="android.intent.action.MAIN"/>
      <category android:name="android.intent.category.LAUNCHER"/>
    </intent-filter>
  </activity-alias>

	<!-- icon2 切换 -->
  <activity-alias
                  android:name="icon2"
                  android:enabled="false"
                  android:exported="true"
                  android:label="cicon_2"
                  android:icon="@mipmap/ic_launcher2"
                  android:targetActivity=".MainActivity"
                  android:launchMode="singleTop"
                  android:theme="@style/LaunchTheme"
                  android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
                  android:hardwareAccelerated="true"
                  android:windowSoftInputMode="adjustResize">
    <meta-data
               android:name="io.flutter.embedding.android.NormalTheme"
               android:resource="@style/NormalTheme"
               />
    <intent-filter>
      <action android:name="android.intent.action.MAIN"/>
      <category android:name="android.intent.category.LAUNCHER"/>
    </intent-filter>
  </activity-alias>

	<!-- icon3 切换 -->
  <activity-alias
                  android:name="icon3"
                  android:enabled="false"
                  android:exported="true"
                  android:label="cicon_3"
                  android:icon="@mipmap/ic_launcher3"
                  android:targetActivity=".MainActivity"
                  android:launchMode="singleTop"
                  android:theme="@style/LaunchTheme"
                  android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
                  android:hardwareAccelerated="true"
                  android:windowSoftInputMode="adjustResize">
    <meta-data
               android:name="io.flutter.embedding.android.NormalTheme"
               android:resource="@style/NormalTheme"
               />
    <intent-filter>
      <action android:name="android.intent.action.MAIN"/>
      <category android:name="android.intent.category.LAUNCHER"/>
    </intent-filter>
  </activity-alias>

</application>
```

