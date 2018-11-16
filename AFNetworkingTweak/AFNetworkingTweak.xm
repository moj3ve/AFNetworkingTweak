
//  Created by BandarHelal
// @BandarHL

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <AVFoundation/AVFoundation.h>
#import <Security/Security.h>
#import "AFNetworking.h"
#import "SCLAlertView.h"
%config(generator=internal)


@interface SCLoginV2ViewController : UIViewController
@end

@interface SCLoginV2ViewController (AFNetworkingTweak)
@end


%hook SCLoginV2ViewController
- (void)backButtonPressed:(id)arg1 {
    
    // setup SCLAlertView With TextField
    SCLALertViewTextFieldBuilder *textfiled = [SCLALertViewTextFieldBuilder new].title(@"inter URL of file");
    SCLALertViewButtonBuilder *DownloadButton = [[SCLALertViewButtonBuilder alloc] init];
    DownloadButton.title(@"Download");
    
    // add action of button "in action well run AFNetworking"
    DownloadButton.actionBlock(^{
        //NSLog(@"The URl is: %@", textfiled.textField.text);
        
        // setup configuration
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        
        // setup URL with requset
        NSURL *URL = [NSURL URLWithString:textfiled.textField.text];
        NSURLRequest *requset = [NSURLRequest requestWithURL:URL];
        
        // setup downloadTask
        NSURLSessionDownloadTask *DownloadTask = [manager downloadTaskWithRequest:requset progress:nil destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            
            // Document Path
            NSURL *documentsDIRURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
            return [documentsDIRURL URLByAppendingPathComponent:[response suggestedFilename]];
            
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            
            if (error) {
                NSLog(@"%@", error);
                
                // Error message
                NSString *meser = [NSString stringWithFormat:@"Error With: %@", error];
                
                // response message
                NSString *res = [NSString stringWithFormat:@"%@", response];
                
                
                // error alert
                UIAlertController *con = [UIAlertController alertControllerWithTitle:@"hi" message:meser preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:nil];
                
                UIAlertAction *resaction = [UIAlertAction actionWithTitle:@"view Response" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    // Response Alert
                    UIAlertView *alertres = [[UIAlertView alloc] initWithTitle:@"hi" message:res delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
                    [alertres show];
                    
                }];
                [con addAction:okaction];
                [con addAction:resaction];
                [self presentViewController:con animated:YES completion:nil];
            } else {
                // Successfully message
                NSString *mes = [NSString stringWithFormat:@"Successfully Download File in: %@", filePath];
                
                // Successfully alert
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"hi" message:mes delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
            
        }];
        // resume Task
        [DownloadTask resume];
    });
    
    // create a builder and alert & hide/show Animation & Color & style & title & message
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
    // color alert
    //showbuilder.color([UIColor blueColor]);
    
    
    // show builder :)
    [showbuilder showAlertView:builder.alertView onViewController:self];
    
}


%end
