//
//  IJDocument.h
//  IKJayma
//
//  Created by Tom Ryan on 8/7/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IJDocumentProtocol <NSObject>
@property (nonatomic, strong) NSString *documentId;
/*! \brief ABSTRACT METHOD. You'll need to write your custom implementation.
 *
 *   Init an AbstractDocument with a dictionary.
 */
-(id)initWithDictionary:(NSDictionary *)dictionary;
/*! \brief ABSTRACT METHOD. You'll need to write your custom implementation.
 *
 *   Refresh the AbstractDocument with a dictionary.
 */
-(void)refreshWithDictionary:(NSDictionary *)dictionary;
/*! \brief ABSTRACT METHOD. You'll need to write your custom implementation.
 *
 *   Retrieve a dictionary representation of the AbstractDocument.
 */
-(NSDictionary *)dictionaryRepresentation;

- (NSString *)documentId;
- (void)setDocumentId:(NSString *)documentId;
@end
