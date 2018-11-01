import UIKit
import WebKit

class Cell:UICollectionViewCell {
    var item = Item() { didSet {
        accessibilityLabel = item.text.string
        text.attributedText = item.text
        updateFlag()
    } }
    private weak var web:WKWebView!
    private weak var text:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .white
        isUserInteractionEnabled = false
        accessibilityHint = .local("Cell.hint")
        isAccessibilityElement = true
        makeOutlets()
    }
    
    required init?(coder:NSCoder) { return nil }
    
    private func makeOutlets() {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.isUserInteractionEnabled = false
        text.numberOfLines = 0
        text.font = .preferredFont(forTextStyle:.body)
        if #available(iOS 10.0, *) {
            text.adjustsFontForContentSizeCategory = true
        }
        contentView.addSubview(text)
        self.text = text

        let web = WKWebView()
        web.translatesAutoresizingMaskIntoConstraints = false
        web.isUserInteractionEnabled = false
        contentView.addSubview(web)
        self.web = web
        
        web.topAnchor.constraint(equalTo:topAnchor, constant:10).isActive = true
        web.bottomAnchor.constraint(equalTo:bottomAnchor, constant:-10).isActive = true
        web.leftAnchor.constraint(equalTo:leftAnchor).isActive = true
        web.widthAnchor.constraint(equalToConstant:80).isActive = true
        
        text.centerYAnchor.constraint(equalTo:centerYAnchor).isActive = true
        text.leftAnchor.constraint(equalTo:web.rightAnchor, constant:10).isActive = true
        text.rightAnchor.constraint(equalTo:rightAnchor, constant:-20).isActive = true
    }
    
    private func updateFlag() {
        if let flag = item.flagImage {
            fadeIn(flag:flag)
        } else if let url = item.flagURL {
            web.alpha = 0
            DispatchQueue.global(qos:.background).async { [weak self] in self?.request(url:url) }
        }
    }
    
    private func request(url:URL) {
        URLSession.shared.dataTask(with:url) { [weak self] (data, _, _) in
            guard let data = data, let flag = String(data:data, encoding:.utf8) else { return }
            self?.item.flagImage = flag
            DispatchQueue.main.async { [weak self] in self?.fadeIn(flag:flag) }
        }.resume()
    }
    
    private func fadeIn(flag:String) {
        web.loadHTMLString(flag, baseURL:nil)
        UIView.animate(withDuration:0.3) { [weak self] in self?.web.alpha = 1 }
    }
}
