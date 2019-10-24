/*:
 # Swift 4
 ## Homework
 
 The goal of this homework is to create a linked list in Swift, work with `URLSession`, the `Result` type, and Futures and Promises.
 */
 import Foundation
 import Combine
/*:
 **Task 1:** Create a generic `Element` class with a value property of a generic type `T`. The element should represent an element in a linked list! Each `Element` should have optional `next` and `previous` properties of the type `Element` with the same generic type parameter. Create an initializer that has default values of `nil` for the `next` and `previous` properties (`init(_ value: T, next: Element<T>? = nil, previous: Element<T>? = nil)`).
 */
class Element <T> {
    var value: T
    var next: Element?
    weak var previous: Element?
    
    init(_ value: T, next: Element<T>? = nil, previous: Element<T>? = nil) {
        self.value = value
        self.next = next
        self.previous = previous
    }
}
/*:
 **Task 2:** Create a `LinkedList` class with a generic constraint `T`. The `LinkedList` class should only store an optional reference to the first element in the `LinkedList`, the `head`.
 */
class LinkedList <T> {
    var head: Element<T>?
}
/*:
 **Task 3:** Add an insert method to the `Element` and `LinkedList` that allows the user to insert a value of type `T` at an arbitrary position in the `LinkedList`. Think about a recursive approach (`func insert(_ value: T, at position: Int? = nil)`).
 */
extension Element {
    func insert(value: T, at position: Int? = nil) {
        if position == nil {
            if next == nil {
                let newNext = Element(value, next: next, previous: self)
                next = newNext
                return
            }
            next?.insert(value: value)
        } else {
            let pos = position ?? 0
            if pos <= 0 || next == nil {
                let newNext = Element(value, next: next, previous: self)
                next = newNext
                return
            }
            next?.insert(value: value, at: pos - 1)
        }
    }
}

extension LinkedList {
    func insert(value: T, at position: Int? = nil) {
        if head == nil {
            head = Element(value)
            return
        } else {
            if let pos = position {
                if pos <= 0 {
                    let new = Element(value, next: head, previous: nil)
                    head?.previous = new
                    head = new
                    return
                }
                head?.insert(value: value, at: pos - 1)
            } else {
                head?.insert(value: value)
            }
        }
    }
}
/*:
 **Task 4:** Add a `getValue` method to the `Element` and `LinkedList` that returns a value of type `T?` at a position in the `LinkedList` based on the index (`Int`) passed into the method (`func getValue(at position: Int) -> T?`).
 */
extension Element {
    public func getValue(at position: Int) -> T? {
        if position < 0 {
            return value
        }
        return next?.getValue(at: position - 1)
    }
}

extension LinkedList {
    public func getValue(at position: Int) -> T? {
        if head == nil {
            return nil
        }
        return head?.getValue(at: position - 1)
    }
}
/*:
 **Task 5:** Add a `count` property to `Element` and `LinkedList` that returns the number of elements in the LinkedList.
 */
extension LinkedList {
    public var count: Int {
        guard var node = head else {
            return 0
        }
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
}
/*:
 **Task 6:** Create an `Element` and `LinkedList` extension so they conform to `CustomStringConvertible` that offers a computed property named `description` when the element stored in the `LinkedList` or `Element` conforms to the `CustomStringConvertible` protocol. The content of the `description` should be exactly like the build description of Swift Arrays using squared brackets and comma separated values. Reference: "[-2,-1,0,1,2,3]".
 */
extension LinkedList: CustomStringConvertible {
    var description: String {
        var start = "["
        var node = head
        while node != nil {
            guard let current = node else {
                return ""
            }
            start += "\(String(describing: current.value))"
            node = current.next
            if node != nil { start += "," }
        }
        return start + "]"
    }
}
/*:
 **Task 7:** Create an instance of `LinkedList` that stores `Int` instances named `list`. Append multiple values at different indices and test your implementations of all functions/properties.
 */

let list = LinkedList<Int>()
list.insert(value: 0)
list.insert(value: 2)
list.insert(value: 1, at: 0)
list.insert(value: 3)
list.insert(value: 5)
list.insert(value: 4, at: 4)
print("Number of Values in List: \(list.count)")
print("Description of List: \(list.description)")
print("Second value of List: \(String(describing: list.getValue(at: 1)))")

/*:
 **Task 8:** Create a class named `UserManager` that stores a list of `User` objects (`users`). The `User` objects should be encodable and decodable to the JSON found at "https://jsonplaceholder.typicode.com/users". You only need to encode and decode the `id`, `name`, `username` and `email` properties, leave out everything else provided by "https://jsonplaceholder.typicode.com/users". The class should have a method called `loadUsers()` that loads the users from jsonplaceholder.typicode.com and stores them in a `users` array. Use combine `Publisher` and operators to get a list of all `User`s from "https://jsonplaceholder.typicode.com/users".
 */
class User: Codable {
    var id: Int
    var name: String
    var username: String
    var email: String
    
    init(id: Int, name: String, username: String, email: String) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
    }
}

class UserManager {
    var users: [User] = []
    var publisher: AnyCancellable?
    
    func loadUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            fatalError("Invalid URL!")
        }
        let session = URLSession.shared
        session.dataTaskPublisher(for: url)
        publisher = session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [User].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { newUsers in
                self.users.append(contentsOf: newUsers)
        })
    }
}

let userManager = UserManager()
userManager.loadUsers()
/*:
**Bonus:** Extend the `User` struct to store an array of `Album` (`albums`). Extend the `loadUsers()` method in the `UserManager` to chain a request to "https://jsonplaceholder.typicode.com/albums?userId=USERID" with `USERID` is beeing replaces with the actual `User` `id` property value to get all the albums of a single user. Cascade the call using `flatMap` and a separate `Publisher` to load the corresponding `Albums` per user.
*/

/*:
 # Congratulations!
 ## You completed your fourth Swift homework! 👩‍💻👨‍💻
 Please submit it to your tutor as described in the slides. They will almost certainly have comments, so be prepared to re-iterate based on their feedback.
*/
