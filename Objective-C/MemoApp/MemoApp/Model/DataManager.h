//
//  DataManager.h
//  MemoApp
//
//  Created by 김태호 on 2023/07/11.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (readonly, strong) NSManagedObjectContext* mainContext;
@property (strong, nonatomic) NSMutableArray* memoList;
 
- (void) saveContext;
- (void) fetchMemo;
- (void) addNewMemo: (NSString*)memo;

+ (instancetype) sharedInstance;


@end

NS_ASSUME_NONNULL_END
