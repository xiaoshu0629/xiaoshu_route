#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ModuleServiceCenter.h"
#import "ModuleServiceProtocol.h"
#import "URLSchemeCenter.h"

FOUNDATION_EXPORT double module_schemeCenterVersionNumber;
FOUNDATION_EXPORT const unsigned char module_schemeCenterVersionString[];

