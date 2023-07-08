//
//  Memo.m
//  MemoApp
//
//  Created by Nick on 2023/07/04.
//

#import "Memo.h"

@implementation Memo

static NSMutableArray* _dummyMemoList = nil;

- (instancetype) initWithCotent:(NSString*) content {
    self = [super init];
    if (self != nil) {
        _content = content;
        _date = [NSDate date];
    }
    return self;
}

+ (NSMutableArray*) dummyMemoList {
    if (_dummyMemoList == nil) {
        Memo* memo1 = [[Memo alloc] initWithCotent:@"첫번째 메모"];
        Memo* memo2 = [[Memo alloc] initWithCotent:@"두번째 메모"];
        
        _dummyMemoList =  [NSMutableArray arrayWithObjects:memo1, memo2, nil];
    }
    
    return _dummyMemoList;
}

@end
