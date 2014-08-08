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
#import "IJDocumentProtocol.h"

@interface IJAbstractRepository : NSObject
/*! The server url.*/
@property (nonatomic,retain) NSString * serverUrl;
/*! The path for your custom entity.*/
@property (nonatomic,retain) NSString * basePath;
/*! The backend that will handle all the HTTP operations.*/
@property (nonatomic,retain) IJAbstractBackend * backend;
/*! \brief ABSTRACT METHOD. You'll need to write your custom implementation.
 *
 *   You'll need to create and set your backend, and set the server url and path for the current entity.
 */
-(id)initWithBackend:(IJAbstractBackend *)backend;
/*! \brief Create a document in the server.
 *
 *   This will do a POST call to server with the received object and retrieve an AbstractDocument.
 */
-(void)createDocument:(id<IJDocumentProtocol>)document success:(void (^)(id<IJDocumentProtocol> document) )success failure:(void (^)(IJError *error))failure;
/*! \brief Update a document in the server.
 *
 *   This will do a PUT call to server with the received object and retrieve the updated AbstractDocument.
 */
-(void)updateDocument:(id<IJDocumentProtocol>)document success:(void (^)(id<IJDocumentProtocol> document) )success failure:(void (^)(IJError *error))failure;
/*! \brief Delete a document in the server.
 *
 *   This will do a DELETE call to server with the received object and returns a BOOL.
 */
-(void)deleteDocument:(id<IJDocumentProtocol>)document success:(void (^)(BOOL successful) )success failure:(void (^)(IJError *error))failure;
/*! \brief Delete a document in the server.
 *
 *   This will do a DELETE call to server with the received object ID and returns a BOOL.
 */
-(void)deleteDocumentWithId:(NSString *)documentId success:(void (^)(BOOL successful) )success failure:(void (^)(IJError *error))failure;
/*! \brief Find a document in the server.
 *
 *   This will do a GET call to server with the received object ID and returns an AbstractDocument.
 */
-(void)findDocumentWithId:(NSString *)documentId success:(void (^)(id<IJDocumentProtocol> document) )success failure:(void (^)(IJError *error))failure;
/*! \brief Find a list of documents in the server.
 *
 *   This will do a GET call to server with the received search conditions and returns an array filled with AbstractDocuments.
 */
-(void)findDocumentsWithConditions:(NSDictionary *)searchConditions success:(void (^)(NSArray *documents) )success failure:(void (^)(IJError *error))failure;
/*! \brief Find all documents in the server.
 *
 *   This will do a GET call to server and returns an array filled with all AbstractDocuments in server.
 */
-(void)findAllDocumentsWithSuccess:(void (^)(NSArray *documents) )success failure:(void (^)(IJError *error))failure;
/*! \brief Refresh a local document.
 *
 *   This will do a GET call to server with the received Abstractdocument reference and update it.
 */
-(void)refreshDocument:(id<IJDocumentProtocol>)document success:(void (^) (BOOL success))success failure:(void (^)(IJError *error))failure;
/*! \brief ABSTRACT METHOD. You'll need to write your custom implementation.
 *
 *  You'll need to init your custom AbstractDocument initWithDictionary method to write your custom entity.
 */
-(id<IJDocumentProtocol>)writeDocumentWithResponseObject:(NSDictionary *)responseObject;
@end
