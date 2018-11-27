//
//  ViewController.m
//  blip-sdk-objective-c
//
//  Created by Curupira on 11/01/17.
//  Copyright © 2017 Curupira. All rights reserved.
//

#import "ViewController.h"
#import "BlipChat/BlipChat-swift.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)openThread:(id)sender {
    BlipOptions *options = [BlipOptions alloc];
    if ([sender tag] == 0) {
        options = [options init] ;
    } else if([sender tag] == 1) {
        AuthConfig *authConfig = [[AuthConfig alloc] initWithAuthType:AuthTypeDev userIdentity:@"ObjcTest1" userPassword:@"123456"];
        Account *account = [[Account alloc] initWithFullname:@"iosName1" email:@"iosEmail1@email.com"];
        account.encryptMessageContent = TRUE;
        options = [options initWithAuthType:authConfig account:account];
    } else if([sender tag] == 2) {
        AuthConfig *authConfig = [[AuthConfig alloc] initWithAuthType:AuthTypeDev userIdentity:@"ObjcTest2" userPassword:@"123456"];
        Account *account = [[Account alloc] initWithFullname:@"iosName2" email:@"iosEmail2@email.com"];
        account.encryptMessageContent = TRUE;
        options = [options initWithAuthType:authConfig account:account];
    } else if([sender tag] == 3) {
        AuthConfig *authConfig = [[AuthConfig alloc] initWithAuthType:AuthTypeDev userIdentity:@"ObjcTest3" userPassword:@"123456"];
        Account *account = [[Account alloc] initWithFullname:@"iosName3" email:@"iosEmail3@email.com"];
        options = [options initWithAuthType:authConfig account:account];
    }
    options.windowTitle = @"Objective C";
    [BlipClient openBlipThreadWithMyView:self appKey:@"YOUR-APP-KEY"  options:options error:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
