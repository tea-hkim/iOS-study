//
//  DetailViewController.m
//  MemoApp
//
//  Created by 김태호 on 2023/07/09.
//

#import "DetailViewController.h"
#import "ComposeViewController.h"
#import "DataManager.h"

@interface DetailViewController () <UITableViewDataSource>

@property (strong, nonatomic) NSDateFormatter* formatter;
@property (weak, nonatomic) IBOutlet UITableView *memoTableView;
- (IBAction)deleteButtonTapped:(id)sender;

@end

@implementation DetailViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ComposeViewController* vc = [[segue.destinationViewController childViewControllers] objectAtIndex:0];
    vc.editMemo = self.memo;
}

-(void)viewWillAppear:(BOOL)animated {
    [self.memoTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateStyle = NSDateFormatterMediumStyle;
    self.formatter.timeStyle = NSDateFormatterMediumStyle;
    self.formatter.locale = [NSLocale localeWithLocaleIdentifier:@"Ko_kr"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"memoCell" forIndexPath:indexPath];
        cell.textLabel.text = self.memo.content;
        return cell;
    } else if(indexPath.row == 1) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"dateCell" forIndexPath:indexPath];
        cell.textLabel.text = [self.formatter stringFromDate:self.memo.date];
        return cell;
    }
    
    
    return [UITableViewCell alloc];
}


- (IBAction)deleteButtonTapped:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"삭제 확인" message:@"메모를 삭제하시겠습니까?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirmAction = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [[DataManager sharedInstance] deleteMemo:self.memo];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:confirmAction];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
