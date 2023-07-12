//
//  DataManager.m
//  MemoApp
//
//  Created by 김태호 on 2023/07/11.
//

#import "DataManager.h"
#import <CoreData/CoreData.h>
#import "Memo+CoreDataProperties.h"

@implementation DataManager

+ (instancetype) sharedInstance {
    static DataManager* sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DataManager alloc] init];
        sharedInstance.memoList = [[NSMutableArray alloc] init];
    });
    
    return sharedInstance;
}

- (NSManagedObjectContext*) mainContext {
    return self.persistentContainer.viewContext;
}

- (void)fetchMemo {
    NSFetchRequest* request = [[NSFetchRequest alloc] initWithEntityName:@"Memo"];
    NSSortDescriptor* sortByDateDesc = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    request.sortDescriptors = @[sortByDateDesc];
    
    NSError* error = nil;
    NSArray* result = [self.mainContext executeFetchRequest:request error:&error];
    [self.memoList setArray: result];
}

- (void) addNewMemo: (NSString*)memo {
    Memo* newMemo = [[Memo alloc] initWithContext:self.mainContext];
    newMemo.content = memo;
    newMemo.date = [NSDate date];
    [self saveContext];
}

- (void) deleteMemo: (Memo*)memo {
    if (memo != nil) {
        [self.mainContext deleteObject: memo];
        [self saveContext];
    }
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"MemoAppModel"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {

        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
