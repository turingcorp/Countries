import UIKit

class Cell:UICollectionViewCell {
    var item = Item() { didSet {
        
    } }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
    }
    
    required init?(coder:NSCoder) { return nil }
}
