import struct InjectPropertyWrapper.Inject

class MockObject<T> {
    @Inject var value: T
    @Inject(name: "named") var namedValue: T
}

class MockObjectOptional<T> {
    @Inject var value: T?
    @Inject(name: "named") var namedValue: T?
}
