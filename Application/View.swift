import UIKit

class View:UIViewController,
    UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    private weak var collection:UICollectionView?
    private var items = [Item]() { didSet { collection?.reloadData() } }
    private let presenter = Presenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = .local("View.title")
        presenter.itemsUpdated = { [weak self] items in self?.items = items }
        makeOutlets()
    }
    
    func searchBar(_:UISearchBar, textDidChange text:String) {
        
    }
    
    func searchBarSearchButtonClicked(_ search:UISearchBar) { search.resignFirstResponder() }
    func collectionView(_:UICollectionView, numberOfItemsInSection:Int) -> Int { return items.count }
    
    func collectionView(_:UICollectionView, cellForItemAt index:IndexPath) -> UICollectionViewCell {
        let cell = collection?.dequeueReusableCell(withReuseIdentifier:"cell", for:index) as! Cell
        cell.item = items[index.item]
        return cell
    }
    
    private func makeOutlets() {
        let typeTitle = UILabel()
        typeTitle.translatesAutoresizingMaskIntoConstraints = false
        typeTitle.text = .local("View.type")
        typeTitle.isUserInteractionEnabled = false
        view.addSubview(typeTitle)
        
        let types:[String] = [.local("View.typeName"), .local("View.typeCapital"), .local("View.typeLanguage"),
                              .local("View.typeRegion"), .local("View.typeCurrency")]
        let type = UISegmentedControl(items:types)
        type.translatesAutoresizingMaskIntoConstraints = false
        type.selectedSegmentIndex = 0
        view.addSubview(type)
        
        let orderTitle = UILabel()
        orderTitle.translatesAutoresizingMaskIntoConstraints = false
        orderTitle.text = .local("View.order")
        orderTitle.isUserInteractionEnabled = false
        view.addSubview(orderTitle)
        
        let orders:[String] = [.local("View.orderCloser"), .local("View.orderFurther"), .local("View.orderName")]
        let order = UISegmentedControl(items:orders)
        order.translatesAutoresizingMaskIntoConstraints = false
        order.selectedSegmentIndex = 0
        view.addSubview(order)
        
        let search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.placeholder = .local("View.search")
        search.searchBarStyle = .minimal
        search.autocorrectionType = .yes
        search.autocapitalizationType = .sentences
        search.spellCheckingType = .yes
        search.keyboardType = .asciiCapable
        search.delegate = self
        view.addSubview(search)
        
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = .zero
        flow.minimumLineSpacing = 1
        flow.minimumInteritemSpacing = 0
        
        let collection = UICollectionView(frame:.zero, collectionViewLayout:flow)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .groupTableViewBackground
        collection.alwaysBounceVertical = true
        collection.delegate = self
        collection.dataSource = self
        collection.register(Cell.self, forCellWithReuseIdentifier:"cell")
        view.addSubview(collection)
        self.collection = collection
        
        typeTitle.topAnchor.constraint(equalTo:view.topAnchor, constant:10).isActive = true
        typeTitle.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        
        type.topAnchor.constraint(equalTo:typeTitle.bottomAnchor, constant:5).isActive = true
        type.leftAnchor.constraint(equalTo:view.leftAnchor, constant:5).isActive = true
        type.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-5).isActive = true
        
        orderTitle.topAnchor.constraint(equalTo:type.bottomAnchor, constant:20).isActive = true
        orderTitle.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        
        order.topAnchor.constraint(equalTo:orderTitle.bottomAnchor, constant:5).isActive = true
        order.leftAnchor.constraint(equalTo:view.leftAnchor, constant:20).isActive = true
        order.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-20).isActive = true
        
        search.topAnchor.constraint(equalTo:order.bottomAnchor, constant:20).isActive = true
        search.leftAnchor.constraint(equalTo:view.leftAnchor, constant:10).isActive = true
        search.rightAnchor.constraint(equalTo:view.rightAnchor, constant:-10).isActive = true
        search.heightAnchor.constraint(equalToConstant:36).isActive = true
        
        collection.topAnchor.constraint(equalTo:search.bottomAnchor, constant:20).isActive = true
        collection.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        collection.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .always
            collection.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            collection.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        }
    }
}
