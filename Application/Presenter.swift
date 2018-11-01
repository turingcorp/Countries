import UIKit
import CoreLocation
import Countries

class Presenter:Delegate {
    var itemsUpdated:(([Item]) -> Void)?
    private let catalog = Catalog()
    private let formatter = NumberFormatter()
    
    init() {
        formatter.numberStyle = .decimal
    }
    
    func load() {
        catalog.delegate = self
        catalog.load(data:try! Data(contentsOf:Bundle.main.url(forResource:"Countries", withExtension:"json")!))
    }
    
    func countriesUpdated() {
        DispatchQueue.global(qos:.background).async { [weak self] in
            guard let items = self?.makeItems() else { return }
            DispatchQueue.main.async { [weak self] in
                self?.itemsUpdated?(items)
            }
        }
    }
    
    func locationDenied() {
        let alert = UIAlertController(title:.local("Presenter.locationDenied"), message:nil, preferredStyle:.alert)
        alert.addAction(UIAlertAction(title:.local("Presenter.continue"), style:.default, handler:nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated:true)
    }
    
    func updated(location:CLLocation) {
        catalog.location = location
    }
    
    func updated(query:String) {
        catalog.query = query
    }
    
    @objc func updated(type:UISegmentedControl) {
        switch type.selectedSegmentIndex {
        case 1: catalog.searchByCapital()
        case 2: catalog.searchByLanguage()
        case 3: catalog.searchByRegion()
        case 4: catalog.searchByCurrency()
        default: catalog.searchByName()
        }
    }
    
    @objc func updated(order:UISegmentedControl) {
        switch order.selectedSegmentIndex {
        case 1: catalog.orderByFurther()
        case 2: catalog.orderByName()
        default: catalog.orderByCloser()
        }
    }
    
    private func makeItems() -> [Item] {
        return catalog.countries.map { country in
            let item = Item()
            item.text = makeText(country:country)
            item.flagURL = URL(string:country.flag)
            return item
        }
    }
    
    private func makeText(country:Country) -> NSAttributedString {
        let text = NSMutableAttributedString()
        text.append(NSAttributedString(string:country.name,
                                       attributes:[.font:UIFont.systemFont(ofSize:20, weight:.bold)]))
        if let population = formatter.string(from:NSNumber(value:country.population)) {
            text.append(NSAttributedString(string:String.local("Presenter.population") + population))
        }
        var area = String.local("Presenter.area")
        if #available(iOS 10.0, *) {
            let measure = MeasurementFormatter()
            measure.unitStyle = .long
            measure.unitOptions = .naturalScale
            measure.numberFormatter.maximumFractionDigits = 1
            area += measure.string(from:Measurement(value:country.area, unit:UnitLength.kilometers)) as String
        } else {
            area += formatter.string(from:NSNumber(value:country.area)) ?? String()
        }
        text.append(NSAttributedString(string:area))
        return text
    }
}
