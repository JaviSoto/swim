import XCTest
import Swim

class BlendPerformanceTests: XCTestCase {

    func testMultiplyBlend() {
        let rgba = Image<RGB, Double>(width: 3840, height: 2160, value: 0)
        var rgb = Image<RGB, Double>(width: 3840, height: 2160, value: 0)
        measure{
            Blender.multiplyBlend(top: rgba, bottom: &rgb)
        }
    }
    
    func testScreenBlend() {
        let rgba = Image<RGB, Double>(width: 3840, height: 2160, value: 0)
        var rgb = Image<RGB, Double>(width: 3840, height: 2160, value: 0)
        measure{
            Blender.screenBlend(top: rgba, bottom: &rgb)
        }
    }
    
    func testOverlayBlend() {
        let rgba = Image<RGB, Double>(width: 3840, height: 2160, value: 1)
        var rgb = Image<RGB, Double>(width: 3840, height: 2160, value: 0)
        measure{
            Blender.overlayBlend(top: rgba, bottom: &rgb)
        }
    }
}
