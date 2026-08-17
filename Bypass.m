#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static BOOL ContainsUpdateText(UIView *view) {
    if ([view isKindOfClass:[UILabel class]]) {
        NSString *text = ((UILabel *)view).text.lowercaseString;

        if ([text containsString:@"get our latest app"] ||
            [text containsString:@"most out of linkedin"] ||
            [text containsString:@"update app"]) {
            return YES;
        }
    }

    for (UIView *subview in view.subviews) {
        if (ContainsUpdateText(subview))
            return YES;
    }

    return NO;
}

static void RemoveUpdatePopup(void) {
    for (UIWindow *window in UIApplication.sharedApplication.windows) {
        UIViewController *vc = window.rootViewController;

        while (vc.presentedViewController) {
            UIViewController *presented = vc.presentedViewController;

            if (presented.isViewLoaded &&
                ContainsUpdateText(presented.view)) {

                [presented dismissViewControllerAnimated:NO
                                              completion:nil];
                return;
            }

            vc = presented;
        }
    }
}

__attribute__((constructor))
static void InitBypass(void) {
    dispatch_async(dispatch_get_main_queue(), ^{

        __block NSInteger attempts = 0;

        [NSTimer scheduledTimerWithTimeInterval:0.35
                                       repeats:YES
                                         block:^(NSTimer *timer) {

            RemoveUpdatePopup();

            attempts++;

            if (attempts >= 120)
                [timer invalidate];
        }];
    });
}
