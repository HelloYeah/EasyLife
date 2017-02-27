//
//  ELLifeViewController.m
//  EasyLife
//
//  Created by Sekorm on 16/10/8.
//  Copyright © 2016年 EL. All rights reserved.
//

#import "ELLifeViewController.h"
#import "ELJokerController.h"
#import "ELHoroscopeView.h"
#import "ELHoroscopeModel.h"
#import "ELBaseRequest.h"
#import "NSString+URL.h"

static const NSString * kJHoroscopeAppKey = @"f0b6f98f5224c5d4f31adc7a07dec884";
@interface ELLifeViewController ()
@property (nonatomic,strong) ELHoroscopeView * horoscopeView;
@property (nonatomic,strong) ELBaseRequest * request;
@end

@implementation ELLifeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"生活";
}

@end
