//
//  IJAbstractRepo.h
//  IKJayma
//
//  Created by Gera on 6/26/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IJAFNetworkingBackend.h"
#import "IJAbstractDocument.h"
@interface IJAbstractRepo : NSObject
@property (nonatomic,retain) NSString * serverUrl;
@property (nonatomic,retain) NSString * basePath;
@property (nonatomic,retain) IJAFNetworkingBackend * backend;
-(id)initWithBackend:(IJAFNetworkingBackend *)backend;
-(void)createDocument:(IJAbstractDocument *)document success:(void (^)(IJAbstractDocument *document) )success failure:(void (^)(NSError *error))failure;
-(IJAbstractDocument *)writeDocumentWithResponseObject:(NSDictionary *)responseObject;
@end
