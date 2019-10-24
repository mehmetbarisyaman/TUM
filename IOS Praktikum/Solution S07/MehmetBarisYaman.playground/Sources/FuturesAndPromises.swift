import Foundation

public class Future<Value> {
    fileprivate var result: Result<Value, Error>? {
        didSet { result.map(report) }
    }
    private lazy var callbacks = [(Result<Value, Error>) -> Void]()
    
    public func observe(with callback: @escaping (Result<Value, Error>) -> Void) {
        callbacks.append(callback)
        result.map(callback)
    }
    
    private func report(result: Result<Value, Error>) {
        for callback in callbacks {
            callback(result)
        }
    }
}

public class Promise<Value>: Future<Value> {
    public init(value: Value? = nil) {
        super.init()
        result = value.map({ .success($0) })
    }
    
    public func resolve(with value: Value) {
        result = .success(value)
    }
    
    public func reject(with error: Error) {
        result = .failure(error)
    }
}
