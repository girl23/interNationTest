//
//  ZLLanguageManager.m
//  internationTest
//
//  Created by wdwk on 2017/1/17.
//  Copyright © 2017年 wksc. All rights reserved.
//

#import "ZLLanguageManager.h"

@interface ZLLanguageManager()
@property (nonatomic,strong) NSBundle *bundle;
@end
@implementation ZLLanguageManager
+(instancetype)shareInstance
{
    static ZLLanguageManager* _manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager=[[self alloc]init];
        
    });
    return _manager;
}
//初始化语言
- (void)initUserLanguage {
    
    NSString *currentLanguage = [self currentLanguage];
    
    if(currentLanguage.length == 0){
        
        //获取系统偏好语言数组
        NSArray *languages = [NSLocale preferredLanguages];
        //第一个为当前语言
        currentLanguage = [languages objectAtIndex:0];
        
        [self saveLanguage:currentLanguage];
    }
    
    [self changeBundle:currentLanguage];
}

//语言和语言对应的.lproj的文件夹前缀不一致时在这里做处理
- (NSString *)languageFormat:(NSString*)language {
    if([language rangeOfString:@"zh-Hans"].location != NSNotFound)
    {//简体中文
        return @"zh-Hans";
    }
    else if([language rangeOfString:@"zh-Hant"].location != NSNotFound)
    {
        //繁体中文；
        return @"zh-Hant";
    }
    else
    {
        //字符串查找
        if([language rangeOfString:@"-"].location != NSNotFound) {
            //除了中文以外的其他语言统一处理@"ru_RU" @"ko_KR"取前面一部分
            NSArray *ary = [language componentsSeparatedByString:@"-"];
            if (ary.count > 1) {
                NSString *str = ary[0];
                return str;
            }
        }
    }
    return language;
}
//设置语言
- (void)setUserlanguage:(NSString *)language {
    
    if (![[self currentLanguage] isEqualToString:language]) {
        [self saveLanguage:language];
        
        [self changeBundle:language];
        
        //改变完成之后发送通知，告诉其他页面修改完成，提示刷新界面
        [[NSNotificationCenter defaultCenter] postNotificationName:ChangeLanguageNotificationName object:nil];
        
    }
}
//改变bundle
- (void)changeBundle:(NSString *)language {
    //1.第一步改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:[self languageFormat:language] ofType:@"lproj" ];
    _bundle = [NSBundle bundleWithPath:path];
}
//保存语言
- (void)saveLanguage:(NSString *)language {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:language forKey:@"userLanguage"];
    [defaults synchronize];
}
//获取当前语言；用户存储的语言；
-(NSString *)currentLanguage
{
    NSUserDefaults * defaults=[NSUserDefaults standardUserDefaults];
    NSString * language=[defaults objectForKey:@"userLanguage"];
    return language;
}
//获取当前语种下的内容
-(NSString*)localizeStringForKey:(NSString*)key value:(NSString*)value{
    
    if (!_bundle) {
        [self initUserLanguage];
    }
    
    if (key.length > 0) {
        if (_bundle) {
            NSString *str = NSLocalizedStringFromTableInBundle(key, @"Localizable", _bundle, value);
            if (str.length > 0) {
                return str;
            }
        }
    }
    return @"";
}
- (UIImage *)getImageWithName:(NSString *)name andType:(NSString*)type {

    NSString *selectedLanguage = [self languageFormat:[self currentLanguage]];
    NSString *path = [[NSBundle mainBundle] pathForResource:[self languageFormat:selectedLanguage] ofType:@"lproj" ];
    UIImage *image =[UIImage imageWithContentsOfFile:[path stringByAppendingPathComponent:[NSString
                                                                                           stringWithFormat:@"%@.%@",name,type]]];
    return image;
}
@end
