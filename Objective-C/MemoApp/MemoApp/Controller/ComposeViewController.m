//
//  ComposeViewController.m
//  MemoApp
//
//  Created by 김태호 on 2023/07/08.
//

#import "ComposeViewController.h"
#import "Memo.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *memoTextView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    NSString* memo = self.memoTextView.text;
    Memo* newMemo = [[Memo alloc] initWithCotent:memo];
    
    [[Memo dummyMemoList] addObject:newMemo];
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
