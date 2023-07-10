//
//  DetailViewController.h
//  MemoApp
//
//  Created by 김태호 on 2023/07/09.
//

#import <UIKit/UIKit.h>
#import "Memo.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Memo* memo;

@end

NS_ASSUME_NONNULL_END
