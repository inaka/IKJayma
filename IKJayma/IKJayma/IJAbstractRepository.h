//
//  IJAbstractRepository.h
//  IKJayma
//
//  Created by Gera on 6/26/14.
//  Copyright (c) 2014 Inaka Labs S.A. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IJAbstractBackend.h"
#import "IJAbstractDocument.h"
#import "IJError.h"
@interface IJAbstractRepository : NSObject
@property (nonatomic,retain) NSString * serverUrl;
@property (nonatomic,retain) NSString * basePath;
@property (nonatomic,retain) IJAbstractBackend * backend;
-(id)initWithBackend:(IJAbstractBackend *)backend;
-(void)createDocument:(IJAbstractDocument *)document success:(void (^)(IJAbstractDocument *document) )success failure:(void (^)(IJError *error))failure;

-(void)updateDocument:(IJAbstractDocument *)document success:(void (^)(IJAbstractDocument *document) )success failure:(void (^)(IJError *error))failure;

-(void)deleteDocument:(IJAbstractDocument *)document success:(void (^)(BOOL successful) )success failure:(void (^)(IJError *error))failure;

-(void)deleteDocumentWithId:(NSString *)documentId success:(void (^)(BOOL successful) )success failure:(void (^)(IJError *error))failure;

-(void)findDocumentWithId:(NSString *)documentId success:(void (^)(IJAbstractDocument *document) )success failure:(void (^)(IJError *error))failure;

-(void)findDocumentsWithConditions:(NSDictionary *)searchConditions success:(void (^)(NSArray *documents) )success failure:(void (^)(IJError *error))failure;

-(void)findAllDocumentsWithSuccess:(void (^)(NSArray *documents) )success failure:(void (^)(IJError *error))failure;

-(void)refreshDocument:(IJAbstractDocument *)document success:(void (^) (BOOL success))success failure:(void (^)(IJError *error))failure;

-(IJAbstractDocument *)writeDocumentWithResponseObject:(NSDictionary *)responseObject;
@end
