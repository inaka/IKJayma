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
 *  You can check the sample code on the sample app inside your IKJayma folder in \code IKJayma/IKJaymaSample \endcode. \nTo use IKJayma, you have to create a CustomRepository class that inherits from AbstractRepository for each different Document that builds your business model. AbstractRepository methods offer basic calls such as create, update, get ( all or some ) and delete. They describe what is expected and returned. Some of them receive AbstractDocuments ( objects that represent a specific entity ) and return AbstractDocuments. Others receive a NSString with the Document ID and return an AbstractDocument or a BOOL. You may want either to use the generic methods of AbstractRepository and cast the AbstractDocuments into your CustomDocuments or write methods in your CustomRepository that call the generic methods, cast them inside your class and return CustomDocuments instead.
 
 * \section how_it_works_sec What is behind?
 *  IKJayma provides an IJAbstractRepository class. It has generic methods that create requests from the data set in the your CustomRepository class (Server URL and Entity Path ) and send them to a request queue on the IJAbstractBackend. Once there, the queue executes requests and calls the success or failure block with a response object and/or an IJError ( A custom error object that provides additional information specifically related to the networking operation that failed ).\n IKJayma also provides IJAFNetworkingBackend ( that inherits from IJAbstractBackend so you can implement your own backend on top of it if you want ), a backend that uses AFNetworking to do the server communication and response management.
 */
