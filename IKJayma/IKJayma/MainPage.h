/*! \mainpage IKJayma by Inaka.
 *
 * \section intro_sec Introduction
 *
 * IKJayma was developed to ease the way we connect with the server. This will provide an easy way to create, update, delete and get entities from a server in a few lines of code.
 *
 * \section install_sec Installation
 *
 * \subsection with_pods With pods
 *
 *  If you are using pods you should add \n
 *  \code pod 'IKJayma' \endcode \code pod 'AFNetworking' \endcode
 *  to your Podfile and run \code pod install \endcode in your terminal.
 *  
 * \subsection without_pods Without pods 
 * Clone the repository running \code git clone git@github.com:inaka/IKJayma.git \endcode in your terminal.
 * Then add the folder IKJayma found in \code IKJayma/IKJayma \endcode to your proyect. 
 * You're gonna need to add AFNetworking too. You can found how to do this here : https://github.com/AFNetworking/AFNetworking
 * \section how_it_works_sec How it works?
 *  IKJayma provides an AbstractRepository class. It will provide generic methods that create requests from the data you set in the your CustomRepository class and send them to a request queue on the AFNetworkingBackend ( that inherites from AbstractBackend so you can implement your own backend if you want ). Methods describes what they expect and what they returns. Some of them receive AbstractDocuments ( objects created from a specific entity ) and returns AbstractDocuemnts, some receive a NSString with the Document ID and returns an AbstractDocument or a BOOL. You may want either use the generic methods and cast the AbstractDocuments into your CustomDocuments or write methods in your abstract repo that calls the generic methods, cast them inside your repository and returns CustomDocuments instead of AbstractDocuments
 */