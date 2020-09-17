//
//  fuckgox.mm
//  fuckgox
//
//  Created by obaby on 2018/1/20.
//  Copyright (c) 2018年 ___obaby@mars___. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#import <Foundation/Foundation.h>
#import "CaptainHook/CaptainHook.h"
#include <notify.h> // not required; for examples only
#import "BABYStringEncoding.h"

// Objective-C runtime hooking using CaptainHook:
//   1. declare class using CHDeclareClass()
//   2. load class using CHLoadClass() or CHLoadLateClass() in CHConstructor
//   3. hook method using CHOptimizedMethod()
//   4. register hook using CHHook() in CHConstructor
//   5. (optionally) call old method using CHSuper()


NSDictionary *ch_dic;

@interface fuckgox : NSObject

@end

@implementation fuckgox

-(id)init
{
	if ((self = [super init]))
	{
	}

    return self;
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

@end


/*
 __int64 __fastcall didFinishLaunching(__int64 a1, __int64 a2, __int64 a3, __int64 a4, __int64 a5)
 {
 SCLAlertView *v5; // x0
 id v6; // ST28_8
 __int64 v7; // x0
 id v8; // ST20_8
 __int64 v9; // x0
 void *v10; // ST10_8
 __int64 v11; // x0
 __int64 v12; // ST00_8
 SCLAlertView *v14; // [xsp+40h] [xbp-30h]
 __int64 v15; // [xsp+48h] [xbp-28h]
 __int64 v16; // [xsp+50h] [xbp-20h]
 __int64 v17; // [xsp+58h] [xbp-18h]
 __int64 v18; // [xsp+60h] [xbp-10h]
 __int64 v19; // [xsp+68h] [xbp-8h]
 
 v19 = a1;
 v18 = a2;
 v17 = a3;
 v16 = a4;
 v15 = a5;
 v5 = (SCLAlertView *)objc_msgSend(&OBJC_CLASS___SCLAlertView, "alloc");
 v14 = (SCLAlertView *)-[SCLAlertView initWithNewWindowWidth:](v5, "initWithNewWindowWidth:", 250.0);
 v6 = ((id (__cdecl *)(SCLAlertView *, SEL, id, id))objc_msgSend)(
 v14,
 "addButton:actionBlock:",
 (id)CFSTR("Official Topic on iOSGods.com!"),
 (id)&__block_literal_global_25);
 v7 = objc_retainAutoreleasedReturnValue(v6);
 objc_release(v7);
 v8 = ((id (__cdecl *)(SCLAlertView *, SEL, id, id))objc_msgSend)(
 v14,
 "addButton:actionBlock:",
 (id)CFSTR("Visit LDOE Club!"),
 (id)&__block_literal_global_33);
 v9 = objc_retainAutoreleasedReturnValue(v8);
 objc_release(v9);
 -[SCLAlertView setShouldDismissOnTapOutside:](v14, "setShouldDismissOnTapOutside:", 0LL);
 v10 = objc_msgSend(&OBJC_CLASS___UIColor, "purpleColor");
 v11 = objc_retainAutoreleasedReturnValue(v10);
 -[SCLAlertView setCustomViewColor:](v14, "setCustomViewColor:", v11, v11, v11);
 objc_release(v12);
 -[SCLAlertView showSuccess:subTitle:closeButtonTitle:duration:](
 v14,
 "showSuccess:subTitle:closeButtonTitle:duration:",
 0LL,
 CFSTR("Last Day on Earth: Survival Cheats by DiDA for iOSGods.com!\n\nYou must login to your iOSGods account to activate the mod. Read the hack's official topic on iOSGods for more information & updates!"),
 CFSTR("Thank you!"),
 60.0);
 -[SCLAlertView alertIsDismissed:](v14, "alertIsDismissed:", &__block_literal_global_48);
 return objc_storeStrong(&v14, 0LL);
 }
 
 */



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
    NSLog(@"BABY_HOOK: makeTextImage original:%@",arg1);
    NSString * ch_string = @"喵喵喵";
    if ([ch_dic objectForKey:arg1]) {
        ch_string =[ch_dic objectForKey:arg1];
        if ([ch_string length]== 0) {
            ch_string = @"喵喵喵";
        }
        NSLog(@"BABY_HOOK: makeTextImage chinese:%@",ch_string);

        return CHSuper(1, HpLib_Graphics,makeTextImage, ch_string);
    }else{
        return CHSuper(1, HpLib_Graphics,makeTextImage, arg1);
    }
}

@class NSPlaceholderString;
CHDeclareClass(NSPlaceholderString);
CHOptimizedMethod(3, self ,id ,NSPlaceholderString, initWithBytes, char *, arg1, length, size_t, arg2 ,encoding , NSStringEncoding, arg3)
{
    //NSLog(@"BABY_HOOK: NSPlaceholderString:initWithBytes original:%s",arg1);
    


    NSString *result=  CHSuper(3, NSPlaceholderString ,initWithBytes, arg1, length, arg2,encoding, arg3);
    
    NSLog(@"BABY_HOOK: strNSString original:%@ , class = %@",result, [result class]);
    
    /*
    if ([result isEqualToString:@"Catbook"]) {
        result = @"猫书";
    }
    */
    
    if ([ch_dic objectForKey:result]) {
        const NSString * ch_string =[ch_dic objectForKey:result];
     
        NSLog(@"BABY_HOOK: strNSString chinese:%@, class = %@",ch_string, [ch_string class]);
        //result = [NSString stringWithFormat:@"%@",ch_string];
        //return  ch_string;
    }
    

    return result;
}

CHOptimizedMethod(1, self, id ,NSPlaceholderString, initWithUTF8String, char *, arg1)
{
    NSLog(@"BABY_HOOK: NSPlaceholderString:initWithUTF8String original:%s",arg1);
    
    
    NSString *result=  CHSuper(1, NSPlaceholderString ,initWithUTF8String, arg1);

    return result;
}

CHOptimizedMethod(2, self, id ,NSPlaceholderString, initWithCString, char *, arg1, encoding, NSStringEncoding,arg2)
{
    NSLog(@"BABY_HOOK: NSPlaceholderString:initWithCString original:%s",arg1);
    
    
    NSString *result=  CHSuper(2, NSPlaceholderString ,initWithCString, arg1,encoding,arg2);
    
    return result;
}


@class EAGLView;
CHDeclareClass(EAGLView);
CHOptimizedMethod(1, self, void, EAGLView, insertText, NSString *, arg1)
{
    NSLog(@"BABY_HOOK: insertText:%@", arg1);
    CHSuper(1, EAGLView, insertText, arg1);
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

CHConstructor // code block that runs immediately upon load
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
        if(!plist){
            NSLog(@"BABY_HOOK: Error: %@",error);
        }
        
        
        //NSLog(@"BABY_HOOK:decode:str= %@, dic=  , error = %@",decodeString, err);
        
        if (!ch_dic  && plist){
            //ch_dic = [[NSDictionary alloc] initWithContentsOfFile:cn_file];
            ch_dic = [[NSDictionary alloc] initWithDictionary:plist];
            NSLog(@"BABY_HOOK: Chinese Dic:\n %@", ch_dic);
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
        
        
        CHLoadLateClass(SCLAlertView);
        CHHook(4, SCLAlertView, showSuccess,subTitle,closeButtonTitle, duration);
        
        
        CHLoadLateClass(IGAuthController);
        CHHook(1, IGAuthController,initAsVIP);
        
        CHLoadLateClass(IGAuth);
        CHHook(1, IGAuth,connect);
        CHHook(1, IGAuth,vipConnect);
         
        // 猫咪后院
        CHLoadLateClass(HpLib_GSystem);
        CHHook(1, HpLib_GSystem, strNSString);
        
        CHLoadLateClass(NSPlaceholderString);
        CHHook(3, NSPlaceholderString ,initWithBytes,length,encoding);
        CHHook(2, NSPlaceholderString ,initWithCString,encoding);
        CHHook(1, NSPlaceholderString ,initWithUTF8String);
        
        CHLoadLateClass(HpLib_Graphics);
        CHHook(1, HpLib_Graphics, makeTextImage);
        
        // 加拿大求生之路
        //CHLoadLateClass(EAGLView);
        //CHHook(1, EAGLView, insertText);
        
	}
}
