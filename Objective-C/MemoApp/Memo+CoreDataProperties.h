//
//  Memo+CoreDataProperties.h
//  MemoApp
//
//  Created by 김태호 on 2023/07/11.
//
//

#import "Memo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Memo (CoreDataProperties)

+ (NSFetchRequest<Memo *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *content;
@property (nullable, nonatomic, copy) NSDate *date;

@end

NS_ASSUME_NONNULL_END
