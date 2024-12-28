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

#import "brotli/decode.h"
#import "brotli/encode.h"
#import "brotli/port.h"
#import "brotli/shared_dictionary.h"
#import "brotli/types.h"

FOUNDATION_EXPORT double BrotliVersionNumber;
FOUNDATION_EXPORT const unsigned char BrotliVersionString[];

