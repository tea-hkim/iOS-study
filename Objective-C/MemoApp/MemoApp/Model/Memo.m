//
//  Memo.m
//  MemoApp
//
//  Created by Nick on 2023/07/04.
//

#import "Memo.h"

@implementation Memo

- (instancetype) initWithCotent:(NSString*) content {
    self = [super init];
    if (self != nil) {
        _content = content;
        _date = [NSDate date];
    }
    return self;
}

+ (NSArray*) dummyMemoList {
    Memo* memo1 = [[Memo alloc] initWithCotent:@"첫번째 메모"];
    Memo* memo2 = [[Memo alloc] initWithCotent:@"두번째 메모"];
    
    return [NSArray arrayWithObjects:memo1, memo2, nil];
}

@end
