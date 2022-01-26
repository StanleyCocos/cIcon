## 移动修改应用图标

#### 简介
flutter 修改应用图片(目前只支持iOS)

#### 环境依赖
#available(iOS 10.3, *)

#### 依赖
```
cicon: 
    git: https://github.com/StanleyCocos/cIcon.git
```

#### 使用
1. 修改图标
```
Cicon.setIcon(name: "icon2");
```
2. 恢复默认图标
```
Cicon.restoreIcon();
```
3. 获取当前图标名称
```
Cicon.currentIcon;
```

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

