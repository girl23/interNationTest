//
//  ViewController.m
//  internationTest
//
//  Created by wdwk on 2017/1/17.
//  Copyright © 2017年 wksc. All rights reserved.
//

#import "ViewController.h"
#import "ZLLanguageManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleStr;
@property (weak, nonatomic) IBOutlet UIButton *chBtn;
@property (weak, nonatomic) IBOutlet UIButton *enBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imgview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //监听按钮点击国际化语言变化；
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:ChangeLanguageNotificationName object:nil];
   //当应用程序刚进入是获取系统的语言环境；
    //获取系统偏好语言数组
    NSArray *languages = [NSLocale preferredLanguages];
    //第一个为当前语言
    NSString* currentLanguage = [languages objectAtIndex:0];
    //保存系统语言
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:currentLanguage forKey:@"userLanguage"];
    [defaults synchronize];
    _imgview.image=[UIImage imageNamed:@"music_background"];
    _titleStr.text=[[ZLLanguageManager shareInstance]localizeStringForKey:@"title" value:@""];
    [_chBtn setTitle:[[ZLLanguageManager shareInstance]localizeStringForKey:@"chbtn" value:@""]
            forState:UIControlStateNormal];
    [_enBtn setTitle:[[ZLLanguageManager shareInstance]localizeStringForKey:@"enbtn" value:@""]
            forState:UIControlStateNormal];
}
- (void)changeLanguage{
    
    _imgview.image=[[ZLLanguageManager shareInstance] getImageWithName:@"music_background" andType:@"png"];
    _titleStr.text=[[ZLLanguageManager shareInstance]localizeStringForKey:@"title" value:@""];
    [_chBtn setTitle:[[ZLLanguageManager shareInstance]localizeStringForKey:@"chbtn" value:@""]
            forState:UIControlStateNormal];
    [_enBtn setTitle:[[ZLLanguageManager shareInstance]localizeStringForKey:@"enbtn" value:@""]
            forState:UIControlStateNormal];
}
- (IBAction)chClick:(id)sender {
    [[ZLLanguageManager shareInstance] setUserlanguage:@"zh-Hans-CN"];
}

- (IBAction)enClick:(id)sender {
    [[ZLLanguageManager shareInstance] setUserlanguage:@"en-CN"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
