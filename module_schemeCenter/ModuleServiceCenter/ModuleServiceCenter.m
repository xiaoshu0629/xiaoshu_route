
#import "ModuleServiceCenter.h"

@interface ModuleServiceCenter()

@property (nonatomic, strong) NSMutableDictionary        *serviceProviderMap;

@end

@implementation ModuleServiceCenter

+ (instancetype)shareCenter
{
    static ModuleServiceCenter *center;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        center = [[ModuleServiceCenter alloc] init];
    });
    
    return center;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        _serviceProviderMap = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)registerService:(Protocol *)service forProvider:(Class)provider
{
    if (service == nil) {
        return;
    }
    
    if (provider == nil) {
        return;
    }
    
    NSString *serviceStr = [NSString stringWithCString:protocol_getName(service) encoding:NSUTF8StringEncoding];
    
    NSString *providerStr = [NSString stringWithCString:class_getName(provider) encoding:NSUTF8StringEncoding];
    
    [_serviceProviderMap setObject:providerStr forKey:serviceStr];
}

- (id)getProviderByService:(Protocol *)service
{
    Class class = [self getClassByService:service];
    
    SEL sel = @selector(getModuleInstance);
    
    Method method = class_getClassMethod(class, sel);
    
    if (method) {
        id (*typed_msgSend)(id, SEL) = (void *)objc_msgSend;
        return typed_msgSend(class, sel);
    }
    
    return class;
}

- (Class)getClassByService:(Protocol *)service
{
    if (service == nil) {
        return nil;
    }
    
    NSString *serviceStr = [NSString stringWithCString:protocol_getName(service) encoding:NSUTF8StringEncoding];
    
    NSString *classStr = [_serviceProviderMap objectForKey:serviceStr];
    
    if (classStr == nil) {
        return nil;
    }
    
    return NSClassFromString(classStr);
}

@end
