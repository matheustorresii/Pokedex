//
//  SearchBoxView.swift
//  Pokedex
//
//  Created by Matheus Torres on 11/06/21.
//

import UIKit
import RxSwift
import RxCocoa

class SearchBoxView: UIView {
    // MARK: - Properties
    weak var delegate: SearchBoxViewDelegate?
    
    // MARK: - UI Properties
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Search your Pokemon"
        // Calculo da leftView para alinhar ao LargeTitle das páginas
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        // Calculo da rightView levando em consideração o botão de pesquisar (Largura botao + Margem)
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: (46 + 16), height: textField.frame.height))
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.tintColor = .pokedexRed
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .pokedexRed
        let image = UIImage(named: "pokeIcon")!
        button.setImage(image.withTintColor(.white), for: .normal)
        button.setImage(image.withTintColor(.pokedexLightGray), for: .highlighted)
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didSearch), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc private func didSearch() {
        let value = textField.text ?? ""
        delegate?.didSearch?(value: value)
    }
    
    // MARK: - UI
    
    private func configureUI() {
        self.backgroundColor = .clear
        configureViews()
    }
    
    private func configureViews() {
        configureTextField()
        configureSearchButton()
    }
    
    private func configureTextField() {
        self.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.center.width.height.equalToSuperview()
        }
    }
    
    private func configureSearchButton() {
        self.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(textField.snp.centerY)
            make.width.height.equalTo(textField.snp.height).inset(8)
            make.right.equalTo(textField.snp.right).inset(8)
        }
    }
}

// MARK: - Delegate & Proxy
@objc protocol SearchBoxViewDelegate: AnyObject {
    @objc optional func didSearch(value: String)
}

class SearchBoxViewDelegateProxy: DelegateProxy<SearchBoxView, SearchBoxViewDelegate>, DelegateProxyType, SearchBoxViewDelegate {
    static func currentDelegate(for object: SearchBoxView) -> SearchBoxViewDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: SearchBoxViewDelegate?, to object: SearchBoxView) {
        object.delegate = delegate
    }
    
    static func registerKnownImplementations() {
        self.register { SearchBoxViewDelegateProxy(parentObject: $0) }
    }
    
    init(parentObject: SearchBoxView) {
        super.init(parentObject: parentObject, delegateProxy: SearchBoxViewDelegateProxy.self)
    }
}

extension Reactive where Base: SearchBoxView {
    var delegate: SearchBoxViewDelegateProxy {
        return SearchBoxViewDelegateProxy.proxy(for: base)
    }
    
    var didSearch: Observable<String> {
        return delegate.methodInvoked(#selector(SearchBoxViewDelegate.didSearch(value:))).map{ $0[0] as! String }
    }
}
