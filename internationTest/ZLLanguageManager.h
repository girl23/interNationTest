//
//  ZLLanguageManager.h
//  internationTest
//
//  Created by wdwk on 2017/1/17.
//  Copyright © 2017年 wksc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define ChangeLanguageNotificationName @"changeLanguage"
@interface ZLLanguageManager : NSObject

-(NSString*)localizeStringForKey:(NSString*)key value:(NSString*)value;
- (void)setUserlanguage:(NSString *)language;
- (UIImage *)getImageWithName:(NSString *)name andType:(NSString*)type;
+ (instancetype)shareInstance;
@end
