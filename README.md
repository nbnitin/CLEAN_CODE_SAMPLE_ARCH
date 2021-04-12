# CLEAN_CODE_SAMPLE_ARCH

this clean code architecture is basically is the updated version of VIPER(View Interactor Presenter Entity(Model) Router). This updated version is called VIP (Viewcontroller Interactor Presenter).

Basic work flow of clean code

1. ViewController this will inherit the display protocol, this display protocol has some functions to update the view. This view controller is also responsible to initiate its own interactor presenter router data set etc...
2. Interactor interacts with presenter using protocol, interactor basically is responsible for api calls
3. Presenter interacts with view controller using display protocol. Presenter is responsible to send data to view controller.
4. Router routes from one vc to other.

Api calls 
1. Api call be done using worker file. There is one base worker which will be inherited by other workers as per project need, here in this project we have user, posts or photos worker.
2. Base worker constains only data provider protocols
3. Data provider protocols contains all services protocol definitions.
4. All workers, which inherits base worker contains the api service for api calls

Services
1. There is one base service will be inherited by other services like users etc.
2. Base service just initiate only network service or other image services
3. Network services just a wrapper for almofire services 

These all services takes request and returns in response

Services also contains the router, this is basically the HTTP routers which contains the http methods, url for api, and parameters as well...
