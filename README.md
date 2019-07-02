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

Then you need to set the global resolver (for example in your app delegate):
```swift
let container = Container()
InjectSettings.resolver = container
```

Register some objects in the container:
```swift
container.register(APIClient.self) { _ in APIClient() }
container.register(MovieRepository.self) { _ in IMDBMovieRepository() }
container.register(MovieRepository.self, name: "netherlands") { _ in IMDBMovieRepository("nl") }
```

Now you can use the @Inject property wrapper to inject objects/services in your own classes:
```swift
class IMDBMovieRepository: MovieRepository {
    @Inject private var apiClient: APIClient
    
    ...
    
    func fetchTop10(completionHandler: @escaping (movies: [Movie]) -> Void) {
        ...
    }
}

class MovieViewModel: BindableObject {
    public var didChange = PassthroughSubject<Void, Never>()
    public private(set) var top10: [Movie]? {
        didSet {
            didChange.send()    
        }
    }

    @Inject private var movieRepository: MovieRepository
    
    func load() {
        movieRepository.fetchTop10() { [weak self] movies in
            self?.top10 = movies
        }
    }
}
```

It is also possible to inject different objects of the same type using the name parameter:
```swift
class MovieViewModel: BindableObject {
    ...
    @Inject private var globalMovieRepository: MovieRepository
    @Inject(name: "netherlands") private var nlMovieRepository: MovieRepository
    ...
}
```

## License

This project is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file.
