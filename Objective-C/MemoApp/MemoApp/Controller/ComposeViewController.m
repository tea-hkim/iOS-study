//
//  ComposeViewController.m
//  MemoApp
//
//  Created by 김태호 on 2023/07/08.
//

#import "ComposeViewController.h"
#import "Memo.h"
#import "DataManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *memoTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.editMemo != nil) {
        self.navigationItem.title = @"메모 편집";
        self.memoTextView.text = self.editMemo.content;
    } else {
        self.navigationItem.title = @"새 메모";
        self.memoTextView.text = @"";
    }
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    NSString* memo = self.memoTextView.text;
    
    if (self.editMemo != nil) {
        self.editMemo.content = memo;
        [[DataManager sharedInstance] saveContext];
    } else {
        [[DataManager sharedInstance] addNewMemo:memo];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
