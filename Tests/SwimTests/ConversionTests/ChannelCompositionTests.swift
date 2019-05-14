import XCTest
import Swim

class ChannelCompositionTests: XCTestCase {
    
    func testCompound() {
        do {
            let intensity = Image(width: 2, height: 2, intensity: [0, 1, 2, 3])
            let alpha = Image(width: 2, height: 2, intensity: [4, 5, 6, 7])
            
            let image = Image(intensity: intensity, alpha: alpha)
            
            XCTAssertEqual(image[channel: .intensity], intensity)
            XCTAssertEqual(image[channel: .alpha], alpha)
        }
        do {
            let red = Image(width: 2, height: 2, intensity: [0, 1, 2, 3])
            let green = Image(width: 2, height: 2, intensity: [4, 5, 6, 7])
            let blue = Image(width: 2, height: 2, intensity: [8, 9, 10, 11])
            
            let image = Image(r: red, g: green, b: blue)
            
            XCTAssertEqual(image[channel: .red], red)
            XCTAssertEqual(image[channel: .green], green)
            XCTAssertEqual(image[channel: .blue], blue)
        }
        do {
            let red = Image(width: 2, height: 2, intensity: [0, 1, 2, 3])
            let green = Image(width: 2, height: 2, intensity: [4, 5, 6, 7])
            let blue = Image(width: 2, height: 2, intensity: [8, 9, 10, 11])
            let alpha = Image(width: 2, height: 2, intensity: [12, 13, 14, 15])
            
            let image = Image(r: red, g: green, b: blue, a: alpha)
            
            XCTAssertEqual(image[channel: .red], red)
            XCTAssertEqual(image[channel: .green], green)
            XCTAssertEqual(image[channel: .blue], blue)
            XCTAssertEqual(image[channel: .alpha], alpha)
        }
        do {
            let red = Image(width: 2, height: 2, intensity: [0, 1, 2, 3])
            let green = Image(width: 2, height: 2, intensity: [4, 5, 6, 7])
            let blue = Image(width: 2, height: 2, intensity: [8, 9, 10, 11])
            let alpha = Image(width: 2, height: 2, intensity: [12, 13, 14, 15])
            
            let image = Image(a: alpha, r: red, g: green, b: blue)
            
            XCTAssertEqual(image[channel: .red], red)
            XCTAssertEqual(image[channel: .green], green)
            XCTAssertEqual(image[channel: .blue], blue)
            XCTAssertEqual(image[channel: .alpha], alpha)
        }
        
        do {
            let rgb = Image<RGB, UInt8>(width: 2, height: 2, data: (0..<12).map { UInt8($0) })
            let a = Image<Intensity, UInt8>(width: 2, height: 2, data: (13..<17).map { UInt8($0) })
            
            let rgba = Image(rgb: rgb, a: a)
            XCTAssertEqual(rgba[channel: .red], rgb[channel: .red])
            XCTAssertEqual(rgba[channel: .green], rgb[channel: .green])
            XCTAssertEqual(rgba[channel: .blue], rgb[channel: .blue])
            XCTAssertEqual(rgba[channel: .alpha], a)
            
            let argb = Image(a: a, rgb: rgb)
            XCTAssertEqual(argb[channel: .red], rgb[channel: .red])
            XCTAssertEqual(argb[channel: .green], rgb[channel: .green])
            XCTAssertEqual(argb[channel: .blue], rgb[channel: .blue])
            XCTAssertEqual(argb[channel: .alpha], a)
        }
    }
}
