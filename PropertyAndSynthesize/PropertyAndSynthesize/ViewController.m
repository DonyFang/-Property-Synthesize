//
//  ViewController.m
//  PropertyAndSynthesize
//
//  Created by 方冬冬 on 2017/8/9.
//  Copyright © 2017年 方冬冬. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Person *person = [[Person alloc] init];
    
    person.name = @"Anthony";
    
    person.age = @"100";
    
    person.gender = @"men";
    
    person.isChange = YES;
    
    NSLog(@"name=%@  age-%@  gender=%@  isChange= %d",[person name],[person age],[person getGender],[person isChangeMethod]);
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
