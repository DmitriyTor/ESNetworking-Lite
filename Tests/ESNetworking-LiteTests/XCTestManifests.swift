import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ESNetworking_LiteTests.allTests),
    ]
}
#endif
