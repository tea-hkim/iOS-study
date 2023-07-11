//
//  Memo+CoreDataProperties.m
//  MemoApp
//
//  Created by 김태호 on 2023/07/11.
//
//

#import "Memo+CoreDataProperties.h"

@implementation Memo (CoreDataProperties)

+ (NSFetchRequest<Memo *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Memo"];
}

@dynamic content;
@dynamic date;

@end
