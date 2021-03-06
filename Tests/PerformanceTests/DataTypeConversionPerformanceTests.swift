import XCTest
import Swim

class DataTypeConversionPerformanceTests: XCTestCase {
    func testUInt8ToDouble() {
        let uint8 = Image<RGB, UInt8>(width: 3840, height: 2160, value: 0)
        measure {
            _ = uint8.cast(to: Double.self)
        }
    }
    
    func testFloatToDouble() {
        let uint8 = Image<RGB, Float>(width: 3840, height: 2160, value: 0)
        measure {
            _ = uint8.cast(to: Double.self)
        }
    }
}
