import Foundation
import Countries

class MockDelegate:Delegate {
    var onUpdated:(() -> Void)?
    
    func countriesUpdated() {
        onUpdated?()
    }
}
