# InjectPropertyWrapper

Provides a generic Swift @Inject property wrapper that can be used to inject objects / services from 
a dependency injection framework of your choice.

## Basic Usage

First, you need to implement the [Sources/InjectPropertyWrapper/Resolver](Resolver) protocol for
the Dependency Injection (DI) framework you are using.

For example, when using [https://github.com/Swinject/Swinject](Swinject):
```swift
extension Container: InjectPropertyWrapper.Resolver {
    public func resolve<T>(_ type: T.Type) -> T {
        return resolve(type)!
    }
    
    public func resolve<T>(_ type: T.Type, name: String) -> T {
        return resolve(type, name: name)!
    }
}
```

Then you need to set the global resolver:
```swift
let container = Container()
InjectConfig.resolver = container
```

Now you can use the @Inject property wrapper to inject objects/services in your own class:

```swift
class Example {
    @Inject private var service: MyService
}
```

## License

This project is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file.
