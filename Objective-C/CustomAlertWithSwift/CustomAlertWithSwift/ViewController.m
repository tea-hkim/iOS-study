//
//  ViewController.m
//  CustomAlertWithSwift
//
//  Created by Nick on 2023/06/27.
//

#import "ViewController.h"
#import "CustomAlertWithSwift-Swift.h"

@interface ViewController () <CustomAlertDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)alertButtonTapped:(UIButton *)sender {
    CustomAlertView * customAlertView = [[CustomAlertView alloc] initWithTitle: @"제목입니다" content: @"내용입니다" confirmText: @"확인" cancelText:@"취소"];
    customAlertView.modalPresentationStyle = UIModalPresentationOverFullScreen;
    customAlertView.delegate = self;
    [self presentViewController:customAlertView animated:NO completion:nil];
}


- (void)cancelAction {
    NSLog(@"✅✅✅✅✅✅✅ Objective-C confirmButton Tapped ✅✅✅✅✅✅✅");
}

- (void)confirmAction {
    NSLog(@"❎❎❎❎❎❎ Objective-C  cancelButton Tapped ❎❎❎❎❎❎");
}

@end
