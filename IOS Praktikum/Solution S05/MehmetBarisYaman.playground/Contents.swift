/*:
 # Swift 3
 ## Homework
 
We will create a travel agency which allows to book flights and overnight stays from its catalog. 🛫 🛏 🛬

 **Important:** In general, you should use higher order functions (reduce, map, filter etc.) in this exercise whenever possible! To keep it simple we will store dates as Strings.
 */
import Foundation
/*:
We added these things to get you started. Check out the code, we will use it in the following tasks. We also added quite some code to the below tasks to make you type less. It's an exciting time to be alive!
*/
struct Customer {
    let fullName: String
    var passportNumber: String?
}

extension Customer: Equatable {
    static func == (lhs: Customer, rhs: Customer) -> Bool {
        return lhs.fullName == rhs.fullName
    }
}
/*:
  **Task 1:** Create a protocol named `Bookable` with two `get`-only properties: `price` of type `Double` and `identifier` of type `String`.

 **Note:** we are using a protocol because inheritance does not make too much sense: the objects *behave* similarly but they are not similar objects!
 */
protocol Bookable {
    var price: Double { get }
    var identifier: String { get }
}
/*:
**Task 2:** Create two structs which implement the protocol:
* `Flight` has an `airlineCode` of type `String` and a `flightNumber` of type `Int`. These two properties are combined to build its `identifier`.
* `OvernightStay` has a property `hotelName` which is also used for its `identifier`.
*/
struct Flight: Bookable {
    // make this class conform to Bookable
    let flightNumber: Int
    let airlineCode: String
    let price: Double
    var identifier: String {
        return "Airline Code: \(airlineCode), Flight Number: \(flightNumber)"
    }
}

struct OvernightStay: Bookable {
    // make this class conform to Bookable
    let hotelName: String
    let price: Double
    var identifier: String {
        return hotelName
    }
}
/*:
 **Task 3:** Take a look at the struct `Booking` below. The components of the booking are stored in a private Array that contains tuples of type `(item: Bookable, date: String)`. Now add a computed property `price` which sums up the price of all components of the booking and multiplies it with the number of customers. Factor in the discount here!
*/
struct Booking {
    let customers: [Customer]
    let discount: Double
    let id: Int
    private(set) var items: [(item: Bookable, date: String)]
    
    init(_ id: Int, customers: [Customer], items: [(Bookable, String)] = [], discount: Double = 0.0) {
        self.id = id
        self.customers = customers
        self.items = items
        self.discount = discount
    }
    
    var price: Double {
        let totalBookPrice = items.reduce(0, { $0 + $1.0.price })
        return totalBookPrice * Double(customers.count) * (1 - discount)
    }
}
/*:
 **Task 4:** Extend `Customer`, `Flight`, `OvernightStay` and `Booking` to conform to `CustomStringConvertible`. We already added the stubs for you. Make sure to have a nice, readable description to each!
 */
extension Customer: CustomStringConvertible {
    var description: String { // add a nice description here
        return "\nCustomer --- Full Name: \(fullName), Passport Number: \(passportNumber ?? ""))"
    }
}

extension Flight: CustomStringConvertible {
    var description: String { // add a nice description here
        return "\nFlight --- ID: \(identifier), Price: \(price)"
    }
}
    
extension OvernightStay: CustomStringConvertible {
    var description: String { // add a nice description here
        return "\nOvernight Stay --- Hotel Name: \(hotelName), Price: \(price)"
    }
}

extension Booking: CustomStringConvertible {
    var description: String { // add a VERY nice description here! 🤔
        return "\nBooking --- ID: \(id), Price: \(price), Discount: \(discount), Customers --- \(customers), Items --- \(items) "
    }
}
/*:
 **Task 5:** This `struct` named `TravelCatalog` already has an array of `Bookable` items. Now it should also be possible to access an item with a `subscript` through its `identifier`.
*/
struct TravelCatalog {
    var items: [Bookable]
    
    subscript(id: String) -> Bookable? {
        return items.first(where: { $0.identifier == id })
    }
}
/*:
 **Task 6:** We already prepared the class `TravelAgency` for you. Add a computed property which returns an array of `Customer`s based on the customers that made their bookings at the travel agency. Remember, use a higher order function wherever possible in this exercise!
 If you need some inspiration, take a look at the `flatMap(_:)` documentation: https://developer.apple.com/documentation/swift/sequence/2905332-flatmap
*/
class TravelAgency {
    private let catalog: TravelCatalog
    var bookings: [Booking] = []
    
    init(catalog: TravelCatalog) {
        self.catalog = catalog
    }
    
    var customers: [Customer] {
        bookings.flatMap({ $0.customers })
    }
}
/*:
 **Task 7:** Create an enumeration conforming to the `Error` protocol named `TravelError` with the following cases: `noPassportAvailable(customers: [Customer])`, `noBookingFound(identifier: Int)`, `notOfferedItem(identifier: String)`, and `noCustomers`.
*/
enum TravelError: Error {
    case noPassportAvailable(customers: [Customer])
    case noBookingFound(identifier: Int)
    case notOfferedItem(identifier: String)
    case noCustomers
}
/*:
 **Task 8:** Add a method `add` of type `(Bookable, String) -> ()` that requires an instance that conforms to `Bookable` and the date as a `String` when the instance should be booked:
 * The method should add the `Bookable` instance to the booking (hint: use the `mutating` keyword).
 * Check if the booking has customers, otherwise throw the appropriate `TravelError`.
 * If the item is a `Flight`, check whether the customers have a passport number, otherwise throw the appropriate `TravelError`.
*/
extension Booking {
    mutating func add(bookable: Bookable, date: String) throws {
        if customers.isEmpty {
            throw TravelError.noCustomers
        }
        if bookable is Flight && customers.allSatisfy({ $0.passportNumber == nil }) {
            throw TravelError.noPassportAvailable(customers: customers)
        }
        items.append((bookable, date))
    }
}
/*:
 **Task 9:** Add the following three methods to the TravelAgency class:
 * A method named `addItem` of type `(Bookable, String, Int) -> ()` that can throw an error. It should take an instance conforming to the `Bookable` protocol, the date when the element should be added and the id of the `Booking` that should be mutated. The method should add an item to the booking with the corresponding id if it is present in the bookings catalog of the travel agency.
 * A method to list all items below a certain price in a log statement.
 * A method to get all the bookings of a customer.
 
 Each method should indicate that it has finished with an appropriate log statement. As always, use descriptive argument labels and higher order functions!
 */
extension TravelAgency {
    func addItem (bookable: Bookable, date: String, id: Int) throws {
        if date.isEmpty {
            throw TravelError.notOfferedItem(identifier: String(id))
        }
        guard var booking = bookings.first(where: { $0.id == id }) else {
            throw TravelError.noBookingFound(identifier: id)
        }
        try booking.add(bookable: bookable, date: date)
        if let bookingIndex = bookings.firstIndex(where: { $0.id == id }) {
            bookings[bookingIndex] = booking
        }
    }
    
    func listAllItemsBelowPrice (threshold: Double) {
        if !bookings.isEmpty {
            let books = bookings.filter { $0.price < threshold }
            print("Items: \(books.map({ $0.items }))")
        } else {
            print("Can not print the items: No Items found!")
        }
    }
    
    func getAllBookingsOfCustomer(customer: Customer) -> [Booking] {
        return bookings.filter({ $0.customers.contains(customer) })
    }
}
/*:
 **Task 10:** Finally add a method `book` of type `([Customer], [(Bookable, String)], Double?) -> ()` to `TravelAgency`, which can throw an error.
 * The first argument should be the customers that want to book a trip, the second argument should be the bookings structured as in the `add` method and the last argument should be the discount.
 * The method should create a new `Booking` and add the given items (use the newly created `add` method).
 * Append the booking to the collection of bookings of the travel agency.
 * This method can throw an error (hint: `throws` keyword). Create a new `Booking`, append it to the `bookings` Array and use the `addItem` method created in the previous exercise to add the items to a newly created booking. Remember that you need to remove the new `Booking` in case of an error, and you need to propagate the error to the calling function.
 */
extension TravelAgency {
    // We added this method for your convenience. See how we use higher order functions?
    private var nextId: Int {
        return bookings.reduce(0, { $0 > $1.id ? $0 : $1.id }) + 1
    }
    
    func book(customers: [Customer], items: [(Bookable, String)], discount: Double?) throws {
        let index = nextId
        let newBooking = Booking(index, customers: customers, discount: discount ?? 0)
        bookings.append(newBooking)
        do {
            try items.forEach({ try addItem(bookable: $0.0, date: $0.1, id: index) })
        } catch let error {
            bookings.remove(at: index)
            throw error
        }
    }
}
/*:
 **Task 11:** Wrap everything up:
* Create at least two flights, overnight stays and customers (one without passport number). Add the flights and overnight stays to a travel catalog and create a travel agency with that catalog.
* List all items below a chosen price and try to book a flight with discount of 0.2 for both customers. Print your corresponding messages for all possible errors.
* Add the missing passport number for the customer and try to book again. Add a helper function at the scope of the playground to reduce the amount of duplicated code for error handling.
* Add an item of type `OvernightStay` to the newly created booking.
* Print all bookings of the agency for one of the customers. Then print all customers of the agency.
 */
// Add this helper function to reduce duplicated error handling. Catch all the errors around booking in here!
func book(agency: TravelAgency, customers: [Customer], items: [(Bookable, String)], discount: Double?) {
    do {
        try agency.book(customers: customers, items: items, discount: discount)
    } catch let TravelError.noBookingFound(id) {
        print("No booking found with id: \(id)")
    } catch TravelError.noCustomers {
        print("No customer found!")
    } catch let TravelError.notOfferedItem(id) {
        print("No item offered with id: \(id) ")
    } catch TravelError.noPassportAvailable(customers) {
        print("No passport number found for customers: \(customers)")
    } catch _ {
        print("Unknown error occured")
    }
}

var flight1 = Flight(flightNumber: 1, airlineCode: "01", price: 10)
var flight2 = Flight(flightNumber: 2, airlineCode: "02", price: 20)
var overStay1 = OvernightStay(hotelName: "Merit Hotel", price: 100)
var overStay2 = OvernightStay(hotelName: "Royal Hotel", price: 200)
var customer1 = Customer(fullName: "Baris Yaman")
var customer2 = Customer(fullName: "Mehmet Yaman", passportNumber: "U67921892")
var travelCatalog = TravelCatalog(items: [flight1, flight2, overStay1, overStay2])
var travelAgency = TravelAgency(catalog: travelCatalog)
travelAgency.listAllItemsBelowPrice(threshold: 30)
book(agency: travelAgency, customers: [customer1, customer2], items: [(flight1, "12/10/2019")], discount: 0.2)
customer1.passportNumber = "U67121212"
book(agency: travelAgency, customers: [customer1], items: [(flight2, "12/10/2019")], discount: 0.2)
book(agency: travelAgency, customers: [customer1], items: [(overStay1, "12/10/2019")], discount: 0)
print(travelAgency.getAllBookingsOfCustomer(customer: customer1))
print(travelAgency.customers)
