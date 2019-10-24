/*:
 # Swift 2
 ## Homework
 
 In this homework we will create a weather station which takes measurements and determines the weather accordingly. ☀️⛈
 
 
 **Task 1:** Create an enumeration called `MeasurementType` which can be `temperature` or `rainfall`.
 */
enum MeasurementType {
    case temperature, rainfall
}
/*:
**Task 2:** Create a type named `City` that stores the `name` of a city and the `country` it is located in. City should conform to the `CustomStringConvertible` protocol using an extension.
*/
struct City {
    var city: String
    var country: String
}

extension City: CustomStringConvertible {
    var description: String {
        return "\(city), \(country)"
    }
}
/*:
**Task 3:** Create a class `WeatherStation`.

**Task 3.1:** The weather station has a private property called `measurements`. This property should be an Array of Tuples of type `(MeasurementType, Double)`. Add a property `city` of type `City` to the class. We should only have to pass an instance of type `City` to the constructor of `WeatherStation`, the measurements Array should be empty after initialization.

**Task 3.2:** Add two ways of adding measurements:
* One should be a method to add a single measurement using two separate arguments: a type (`MeasurementType`) and a value (`Double`). Use descriptive argument labels here!
* The other should be a method that allows an arbitrary number of Tuples of type `(MeasurementType, Double)` to be added to the array. 

Hint: use variadic parameters and the `append(contentsOf:)` method offered by `Array`

**Task 3.3** Add two **computed properties** to your class:
* The property `rainfall` should return the sum of values of all measurements which have the type `.rainfall`.
* The property `meanTemperature` should return the mean of all measurements of type `.temperature` (return `nil` if there are no measurements, as otherwise you would be dividing by zero)
* Use two different ways of iterating over the measurements array with a `for` loop: e.g. a `where` statement and pattern matching
*/
class WeatherStation {
    private var measurements: [(MeasurementType, Double)] = []
    var city: City
    
    init(city: City) {
        self.city = city
    }
    
    func addSingleMeasurement(measurement: MeasurementType, value: Double) {
        let newMeasurement = (measurement, value)
        measurements.append(newMeasurement)
    }
    
    func addMultipleMeasurements(newMeasurements: (MeasurementType, Double)...) {
        measurements.append(contentsOf: newMeasurements)
    }
    
    var rainfall: Double {
        var rainCounter = 0.0
        for (type, value) in measurements where type == MeasurementType.rainfall {
            rainCounter += value
        }
        return rainCounter
    }
    var meanTemparature: Double? {
        let numberOfElements = measurements.count
        if numberOfElements > 0 {
            var counter = 0.0
            var indexCount = 0.0
            for case let (MeasurementType.temperature, value) in measurements {
                counter += value
                indexCount += 1.0
            }
            return counter / indexCount
        } else {
            return nil
        }
    }
}
/*:
**Task 4:** Create an enumeration called `Weather` with three cases: `sunny`, `cloudy` and `rainy`.
*/
enum Weather {
    case sunny, cloudy, rainy
}
/*:
**Task 5:** Add a private method `determineWeather()` to your weather station.
* It should return an Optional `Weather?` and return `nil` if there are no measurements yet.
* Determine a way of returning the correct weather type: e.g. the weather is rainy if there are more than 10mm of rainfall, it’s sunny if the mean temperature is above 20 degrees, otherwise it’s cloudy.
*/
extension WeatherStation {
    private func determineWeather() -> Weather? {
        let numberOfElements = measurements.count
        if numberOfElements > 0 {
            let meanTemperature = meanTemparature ?? 0
            if rainfall > 10 {
                return Weather.rainy
            } else if meanTemperature > 20.0 {
                return Weather.sunny
            } else {
                return Weather.cloudy
            }
        }
        return nil
    }
}
/*:
**Task 6:** Extend `WeatherStation` to make it conform to `CustomStringConvertible`. Implement the `description` property to return a logical textual description of the weather using the result of `determineWeather()`.
* Use `guard let` to determine if the method returns a value. If not, signal that the weather cannot be determined.
* Return a textual description of each weather type. Use the properties `city`, `meanTemperature` and `rainfall` to build the description where appropriate.

Example: "Oh no! There is rain in \(city) today! We have rainfall of \(rainfall) mm."
*/
extension WeatherStation: CustomStringConvertible {
    var description: String {
        guard let condition = determineWeather() else {
            return("The weather can not be determined in \(city).")
        }
        if condition == Weather.sunny {
            if let meanTemperature = meanTemparature {
                return "Great! We have a sunny day with the temparature of \(meanTemperature) in \(city)."
            } else {
                return "Great! We have a sunny day in \(city)."
            }
        } else if condition == Weather.rainy {
            return "Oh no! There is rain in \(city) today! We have rainfall of \(rainfall) mm."
        } else {
            if let meanTemperature = meanTemparature {
                return "The weather is cloudy today in \(city) with the temparature of \(meanTemperature)."
            } else {
                return "The weather is cloudy today in \(city)"
            }
        }
    }
}
/*:
**Task 7:** Extend `WeatherStation` to make it conform to `Equatable`. Two instances should be equal if their weather types are equal. You can use the result of `determineWeather()` here as well.
*/
extension WeatherStation: Equatable {
    static func == (lhs: WeatherStation, rhs: WeatherStation) -> Bool {
        return lhs.determineWeather() == rhs.determineWeather()
    }
}
/*:
**Task 8:** Add a method `compareWeather(to station:)` to the WeatherStation class. It should indicate if the two cities have the same or different weather through a `print` statement.
*/
extension WeatherStation {
    func compareWeather(station: WeatherStation) {
        if self == station {
            print("\(self.city.city) and  \(station.city.city) have same weather")
        } else {
            print("\(self.city.city) and  \(station.city.city) have different weather")
        }
    }
}
/*:
**Task 9:** Create two `WeatherStation` instances, one for Munich and one for e.g. Barcelona. Use a `print` statement on one of them to see what happens if there are no measurements yet.
*/
let munich = WeatherStation(city: City(city: "Munich", country: "Germany"))
let barcelona = WeatherStation(city: City(city: "Barcelona", country: "Spain"))
print(munich.description)
/*:
**Task 10:** Add at least two measurements of each `MeasurementType` to both weather stations. Use both methods that you created at least once. Print out both instances and use the `compareWeather(to station:)` method to see if they are equal.
*/
munich.addSingleMeasurement(measurement: MeasurementType.rainfall, value: 15)
munich.addMultipleMeasurements(newMeasurements: (MeasurementType.temperature, 15.0))
barcelona.addSingleMeasurement(measurement: MeasurementType.rainfall, value: 5)
barcelona.addMultipleMeasurements(newMeasurements: (MeasurementType.temperature, 25.0))
print(munich.description)
print(barcelona.description)
munich.compareWeather(station: barcelona)
print("Useless Print")
