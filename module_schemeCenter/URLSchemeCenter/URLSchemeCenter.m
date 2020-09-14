//
//  URLSchemeCenter.m
//  
//
//  Created by chengshuangshuang on 2019/3/6.
//

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#import "URLSchemeCenter.h"

#import <objc/runtime.h>
#import <objc/message.h>

@interface URLSchemeCenter()

@property (nonatomic, strong) NSMutableDictionary        *schemeMap;

@end

@implementation URLSchemeCenter

+ (instancetype)shareCenter
{
    static URLSchemeCenter *center;

    static dispatch_once_t once;

    dispatch_once(&once, ^{
        center = [[URLSchemeCenter alloc] init];
    });

    return center;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.schemeMap = [[NSMutableDictionary alloc] init];
    }

    return self;
}

- (BOOL)registerURL:(NSURL *)url forCodeBlock:(CodeBlock)codeBlock
{
    if (![url isKindOfClass:NSURL.class]) {
        return NO;
    }

    if (!codeBlock) {
        return NO;
    }

    NSString *key = url.absoluteString.lowercaseString;
    CodeBlock value = [codeBlock copy];

    [self.schemeMap setObject:value forKey:key];

    return YES;
}

- (BOOL)executeURL:(NSURL *)url
{
    if (![url isKindOfClass:NSURL.class]) {
        return NO;
    }

    CodeBlock value = [self codeBlockFromUrl:url];

    if (!value) {
        return NO;
    }

    NSInteger isHttp = [url.scheme isEqualToString:[NSURL URLWithString:GenericHttpURL].scheme] || [url.scheme isEqualToString:[NSURL URLWithString:GenericHttpsURL].scheme];

    if (isHttp) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            value(url);
        });

        return YES;
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *params = [self getQueryObj:url.query];
        value(params);
    });

    return YES;
}


- (NSDictionary *)getQueryObj:(NSString *)string
{
    if (![string isKindOfClass: [NSString class]]) {
        return nil;
    }

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];

    NSArray *queryStringPairs = [string componentsSeparatedByString:@"&"];

    [queryStringPairs enumerateObjectsUsingBlock:^(NSString *queryStringPair, NSUInteger idx, BOOL *stop) {
        NSRange range = [queryStringPair rangeOfString:@"="];
        if (range.location != NSNotFound) {
            NSString *key = [queryStringPair substringToIndex:range.location];
            NSString *value = [queryStringPair substringFromIndex:range.location + 1];
            [params setValue:value forKey:key];
        }
    }];

    return params;
}

- (CodeBlock)codeBlockFromUrl:(NSURL *)url
{
    if ([url.scheme isEqualToString:[NSURL URLWithString:GenericHttpURL].scheme]) {
        
        CodeBlock value = [self.schemeMap objectForKey:GenericHttpURL];
        
        return value;
    }
    
    if ([url.scheme isEqualToString:[NSURL URLWithString:GenericHttpsURL].scheme]) {
        
        CodeBlock value = [self.schemeMap objectForKey:GenericHttpsURL];
        
        return value;
    }
    
    NSString *key = [url.absoluteString componentsSeparatedByString:@"?"].firstObject.lowercaseString;
    
    CodeBlock value = [self.schemeMap objectForKey:key];
    
    return value;
}

@end
