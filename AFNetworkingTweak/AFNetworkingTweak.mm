#line 1 "/Users/mac/Desktop/AFNetworkingTweak/AFNetworkingTweak/AFNetworkingTweak.xm"



#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <AVFoundation/AVFoundation.h>
#import <Security/Security.h>
#import "AFNetworking.h"
#import "SCLAlertView.h"



@interface SCLoginV2ViewController : UIViewController
@end

@interface SCLoginV2ViewController (AFNetworkingTweak)
@end



#include <objc/message.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

__attribute__((unused)) static void _logos_register_hook$(Class _class, SEL _cmd, IMP _new, IMP *_old) {
unsigned int _count, _i;
Class _searchedClass = _class;
Method *_methods;
while (_searchedClass) {
_methods = class_copyMethodList(_searchedClass, &_count);
for (_i = 0; _i < _count; _i++) {
if (method_getName(_methods[_i]) == _cmd) {
if (_class == _searchedClass) {
*_old = method_getImplementation(_methods[_i]);
*_old = method_setImplementation(_methods[_i], _new);
} else {
class_addMethod(_class, _cmd, _new, method_getTypeEncoding(_methods[_i]));
}
free(_methods);
return;
}
}
free(_methods);
_searchedClass = class_getSuperclass(_searchedClass);
}
}
@class SCLoginV2ViewController; 
static Class _logos_superclass$_ungrouped$SCLoginV2ViewController; static void (*_logos_orig$_ungrouped$SCLoginV2ViewController$backButtonPressed$)(_LOGOS_SELF_TYPE_NORMAL SCLoginV2ViewController* _LOGOS_SELF_CONST, SEL, id);

#line 21 "/Users/mac/Desktop/AFNetworkingTweak/AFNetworkingTweak/AFNetworkingTweak.xm"

static void _logos_method$_ungrouped$SCLoginV2ViewController$backButtonPressed$(_LOGOS_SELF_TYPE_NORMAL SCLoginV2ViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1) {
    
    
    SCLALertViewTextFieldBuilder *textfiled = [SCLALertViewTextFieldBuilder new].title(@"inter URL of file");
    SCLALertViewButtonBuilder *DownloadButton = [[SCLALertViewButtonBuilder alloc] init];
    DownloadButton.title(@"Download");
    
    
    DownloadButton.actionBlock(^{
        
        
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        
        NSURL *URL = [NSURL URLWithString:textfiled.textField.text];
        NSURLRequest *requset = [NSURLRequest requestWithURL:URL];
        
        
        NSURLSessionDownloadTask *DownloadTask = [manager downloadTaskWithRequest:requset progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            
            
            NSURL *documentsDIRURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [documentsDIRURL URLByAppendingPathComponent:[response suggestedFilename]];
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"%@", error);
                
                
                NSString *meser = [NSString stringWithFormat:@"Error With: %@", error];
                
                
                NSString *res = [NSString stringWithFormat:@"%@", response];
                
                
                
                UIAlertController *con = [UIAlertController alertControllerWithTitle:@"hi" message:meser preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
                
                UIAlertAction *resaction = [UIAlertAction actionWithTitle:@"view Response" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    
                    UIAlertView *alertres = [[UIAlertView alloc] initWithTitle:@"hi" message:res delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
                    [alertres show];
                    
                }];
                [con addAction:okaction];
                [con addAction:resaction];
                [self presentViewController:con animated:YES completion:nil];
            } else {
                
                NSString *mes = [NSString stringWithFormat:@"Successfully Download File in: %@", filePath];
                
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"hi" message:mes delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
            
        }];
        
        [DownloadTask resume];
    });
    
    
    SCLAlertViewBuilder *builder = [[SCLAlertViewBuilder alloc] init];
    builder.showAnimationType(SCLAlertViewShowAnimationFadeIn);
    builder.hideAnimationType(SCLAlertViewHideAnimationFadeOut);
    builder.addTextFieldWithBuilder(textfiled);
    builder.addButtonWithBuilder(DownloadButton);
    
    
    SCLAlertViewShowBuilder *showbuilder = [[SCLAlertViewShowBuilder alloc] init];
    showbuilder.style(SCLAlertViewStyleEdit);
    showbuilder.title(@"Download Files in Document");
    showbuilder.subTitle(@"Inter URL fo file");
    showbuilder.closeButtonTitle(@"Cancel");
    showbuilder.duration(0.0f);
    
    
    
    [showbuilder showAlertView:builder.alertView onViewController:self];
    
}



static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SCLoginV2ViewController = objc_getClass("SCLoginV2ViewController"); _logos_superclass$_ungrouped$SCLoginV2ViewController = class_getSuperclass(_logos_class$_ungrouped$SCLoginV2ViewController); { _logos_register_hook$(_logos_class$_ungrouped$SCLoginV2ViewController, @selector(backButtonPressed:), (IMP)&_logos_method$_ungrouped$SCLoginV2ViewController$backButtonPressed$, (IMP *)&_logos_orig$_ungrouped$SCLoginV2ViewController$backButtonPressed$);}} }
#line 114 "/Users/mac/Desktop/AFNetworkingTweak/AFNetworkingTweak/AFNetworkingTweak.xm"
