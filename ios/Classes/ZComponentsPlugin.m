#import "ZComponentsPlugin.h"
#import <z_components/z_components-Swift.h>

@implementation ZComponentsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftZComponentsPlugin registerWithRegistrar:registrar];
}
@end
