import Foundation

/// Permite que una variable sea observable
@propertyWrapper
public final class Observable<Value> {
    
    /// Si se notifica el valor actual al agregar un observador
    private var notifyOnAddObserver: Bool = false
    
    struct Observer<Value> {
        weak var observer: AnyObject?
        let block: (Value) -> Void
    }
    
    private var observers = [Observer<Value>]()
    
    public var wrappedValue: Value {
        didSet { notifyObservers() }
    }
    
    ///  Constructor por defecto
    /// - Parameters:
    ///   - wrappedValue: El valor de la variable
    ///   - notifyOnAddObserver: Notificamos el valor inicial cuando se agrega un observer, por defacto `false`
    public init(wrappedValue: Value, notifyOnAddObserver: Bool = false) {
        self.notifyOnAddObserver = notifyOnAddObserver
        self.wrappedValue = wrappedValue
    }
    
    /// Agrega un observador, notifica cada vez que se cambia el valor de la propiedad
    /// - Parameters:
    ///   - observer: La instancia que se agrega como observer
    ///   - observerBlock: clousre que el nuevo valor, cada vez que se cambia
    public func observe(on observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
        observers.append(Observer(observer: observer, block: observerBlock))
        if notifyOnAddObserver {
            observerBlock(self.wrappedValue)
        }
    }
    
    /// Elimina un observador
    /// - Parameter observer: La instancia que está agregado como observador
    public func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }
    
    /// notifica el nuevo valor a todos los observadores registrados
    private func notifyObservers() {
        for observer in observers {
            DispatchQueue.main.async { observer.block(self.wrappedValue) }
        }
    }
}
