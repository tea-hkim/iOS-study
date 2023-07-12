//
//  ComposeViewController.h
//  MemoApp
//
//  Created by 김태호 on 2023/07/08.
//

#import <UIKit/UIKit.h>
#import "Memo+CoreDataProperties.h"

NS_ASSUME_NONNULL_BEGIN

@interface ComposeViewController : UIViewController

@property (strong, nonatomic) Memo* editMemo;

@end

NS_ASSUME_NONNULL_END
