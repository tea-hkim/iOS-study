//
//  ViewController.m
//  ObjectiveCPractice
//
//  Created by Nick on 2024/01/02.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *phoneNumber;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Name: %@, %@", self.name, self.phoneNumber);
}

- (IBAction)buttonTapped:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"알림입니다." message:@"메세지입니다" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *closeAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:closeAction];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
