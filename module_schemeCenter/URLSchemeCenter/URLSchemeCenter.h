//
//  URLSchemeCenter.h
//  
//
//  Created by chengshuangshuang on 2019/3/6.
//

#import <Foundation/Foundation.h>

#define GenericHttpURL          @"http://"
#define GenericHttpsURL         @"https://"

typedef void (^CodeBlock)(id para);

@interface URLSchemeCenter : NSObject

// 单例方法
+ (instancetype)shareCenter;

- (BOOL)registerURL:(NSURL *)url forCodeBlock:(CodeBlock)codeBlock;

- (BOOL)executeURL:(NSURL *)url;

@end
