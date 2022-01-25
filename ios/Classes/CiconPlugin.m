#import "CiconPlugin.h"
#if __has_include(<cicon/cicon-Swift.h>)
#import <cicon/cicon-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "cicon-Swift.h"
#endif

@implementation CiconPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [SwiftCiconPlugin registerWithRegistrar:registrar];
}

@end
