//
//  DetailViewController.m
//  MemoApp
//
//  Created by 김태호 on 2023/07/09.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITableViewDataSource>

@property (strong, nonatomic) NSDateFormatter* formatter;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.formatter = [[NSDateFormatter alloc] init];
    self.formatter.dateStyle = NSDateFormatterMediumStyle;
    self.formatter.timeStyle = NSDateFormatterMediumStyle;
    self.formatter.locale = [NSLocale localeWithLocaleIdentifier:@"Ko_kr"];
    NSLog(@"😀😀😀😀😀😀😀");
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


@end
