//
//  Memo.h
//  MemoApp
//
//  Created by Nick on 2023/07/04.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Memo : NSObject

@property (strong, nonatomic) NSString* content;
@property (strong, nonatomic) NSDate* date;

- (instancetype) initWithCotent:(NSString*) content;

@property (strong, nonatomic, readonly, class) NSMutableArray* dummyMemoList;

@end

NS_ASSUME_NONNULL_END
