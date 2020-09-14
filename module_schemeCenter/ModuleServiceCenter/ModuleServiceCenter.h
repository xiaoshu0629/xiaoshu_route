
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "ModuleServiceProtocol.h"

@interface ModuleServiceCenter : NSObject

+ (ModuleServiceCenter *)shareCenter;

- (void)registerService:(Protocol *)service forProvider:(Class)provider;

- (id)getProviderByService:(Protocol *)service;

@end
