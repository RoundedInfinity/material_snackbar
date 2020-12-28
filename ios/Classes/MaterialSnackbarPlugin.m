#import "MaterialSnackbarPlugin.h"
#if __has_include(<material_snackbar/material_snackbar-Swift.h>)
#import <material_snackbar/material_snackbar-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "material_snackbar-Swift.h"
#endif

@implementation MaterialSnackbarPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMaterialSnackbarPlugin registerWithRegistrar:registrar];
}
@end
