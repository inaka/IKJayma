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

 * \section how_to_use_it_sec How to use it?
 *  You can search for the sample app inside your IKJayma cloned folder in \code IKJayma/IKJaymaSample \endcode You'll have to create a CustomRepository class that inherites from AbstractRepository. AbstractRepository methods offer basic calls such as create, update, get ( all or some ) and delete. They describes what are expected and returned. Some of them receive AbstractDocuments ( objects created from a specific entity ) and returns AbstractDocuemnts, some receive a NSString with the Document ID and returns an AbstractDocument or a BOOL. You may want either use the generic methods of AbstractRepository and cast the AbstractDocuments into your CustomDocuments or write methods in your CustomRepository that calls the generic methods, cast them inside your repository and returns CustomDocuments instead of AbstractDocuments
 
 * \section how_it_works_sec What is behind?
 *  IKJayma provides an IJAbstractRepository class. It has generic methods that create requests from the data set in the your CustomRepository class (Server URL and Entity Path ) and send them to a request queue on the IJAbstractBackend. Once there, the queue executes requests and calls the success or failure block with a response object and an IJError ( A custom Inaka complex error ) if it's necessary.\n IKJayma also provides IJAFNetworkingBackend ( that inherites from IJAbstractBackend so you can implement your own backend if you want ), a backend that uses AFNetworking to do the server comunication and response management.
 */