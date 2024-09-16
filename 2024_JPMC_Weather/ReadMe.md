# Coding Challenge: Weather 

**App features:**
1. Home Screen with app permission request for user location
    ![Home Screen](Images/0home.png)
    ![location request](Images/1LocationPrompt.png)
    
2. Search for weather by current location 
![Current Location](Images/2currentLocation.png)
![Current Location weather](Images/3CurrentLocationCard.png)

3. Search for weather by city search 
![city search](Images/4CitySearch.png)

4. See search history
![Search History](Images/6SearchHistory.png)

** Tests ** 

These are *two contract tests* written in Swift using XCTest and Combine. 
1. CityAPIContractTests
a. **Arrange:** Sets up the test by defining a city name, state code, and country code.
b. **Mock** CityAPI: Creates a mock implementation of the CityAPIProtocol that returns a predefined response (expectedResponse) when fetchCoordinates is called.
c. **Act:** Calls the fetchCoordinates function on the mock CityAPI with the arranged city name, state code, and country code.
d. **Assert:** Verifies that the response received from the mock CityAPI matches the expected response using XCTAssertEqual.

2. WeatherAPIContractTests
a. **Arrange:** Sets up the test by defining a latitude and longitude.
b. **Mock** WeatherAPI: Creates a mock implementation of the WeatherAPIProtocol that returns a predefined response (expectedResponse) when fetchWeather is called.
c. **Act:** Calls the fetchWeather function on the mock WeatherAPI with the arranged latitude and longitude.
d. **Assert:** Verifies that the response received from the mock WeatherAPI matches the expected response using XCTAssertEqual.


/////////////////

Below are the details needed to construct a weather based app where users can look up weather for a city. 

 
1. get the coordinator patten 
2. Must need to be followed MVVM 
3. Dependency Injection must be used 
4. Must need to handle any error scenarios 
5. SwiftUI – Which is mandatory 
6. Test cases - Mandatory
7. used protocols where is needed 
             

Public API
Create a free account at openweathermap.org ✅. Just takes a few minutes. Full documentation for the service below is on their site, be sure to take a few minutes to understand it. 
 
https://api.openweathermap.org/data/2.5/weather?lat=44.34&lon=10.99&appid={API key} 
Built-in geocoding 
Please use Geocoder API if you need automatic convert city names and zip-codes to geo coordinates and the other way around ✅. 
Please note that API requests by city name, zip-codes and city id have been deprecated. Although they are still available for use, bug fixing and updates are no longer available for this functionality. 
Built-in API request by city name 
You can call by city name or city name, state code and country code. Please note that searching by states available only for the USA locations. 
API call 
https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key} 
https://api.openweathermap.org/data/2.5/weather?q={city name},{country code}&appid={API key} 
https://api.openweathermap.org/data/2.5/weather?q={city name},{state code},{country code}&appid={API key} 
  
You will also need icons from here: 
http://openweathermap.org/weather-conditions 
  
### Requirements
These requirements are rather high-level and vague. If there are details I have omitted, it is because I will be happy with any of a wide variety of solutions. Don't worry about finding "the" solution. 
Create a browser or native-app-based application to serve as a basic weather app. 
Search Screen 
Allow customers to enter a US city ✅
Call the openweathermap.org API and display the information you think a user would be interested in seeing. Be sure to has the app download and display a weather icon. ❌
Have image cache if needed 
Auto-load the last city searched upon app launch. ✅
Ask the User for location access, If the User gives permission to access the location ✅, then retrieve weather data by default 
In order to prevent you from running down rabbit holes that are less important to us, try to prioritize the following: 
What is Important 
Proper function – requirements met. 
Well-constructed, easy-to-follow, commented code (especially comment hacks or workarounds made in the interest of expediency (i.e. // given more time I would prefer to wrap this in a blah blah blah pattern blah blah )). 
Proper separation of concerns and best-practice coding patterns ✅. 
Defensive code that graciously handles unexpected edge cases. 
What is Less Important 
UI design – generally, design is handled by a dedicated team in our group. 
Demonstrating technologies or techniques you are not already familiar with (for example, if you aren't comfortable building a single-page app, please don't feel you need to learn how for this). 
iOS: 
For applications that include CocoaPods with their project code, having the Pods included in the code commits as the source is recommended. (Even though it goes against the CocoaPod's general rules).  
Be sure to use safe area insets  
Using Sizeclass wisely for landscape and portrait   
Make sure to use UIKit, we would love to see a combination of both UIKit and SwiftUI if you desire. 
