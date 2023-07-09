//
//  DetailViewController.m
//  MemoApp
//
//  Created by 김태호 on 2023/07/09.
//

#import "DetailViewController.h"

@interface DetailViewController () <UITableViewDataSource>

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"memoCell" forIndexPath:indexPath];
        return cell;
    }
    return [UITableViewCell alloc];
}


@end
