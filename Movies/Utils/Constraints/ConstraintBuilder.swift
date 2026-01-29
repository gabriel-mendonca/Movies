//
//  ConstraintBuilder.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

/// Builder pattern para criação de constraints de forma fluente e reutilizável
final class ConstraintBuilder {
    private var constraints: [NSLayoutConstraint] = []
    private let view: UIView
    
    init(view: UIView) {
        self.view = view
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    /// Adiciona constraint de topo
    @discardableResult
    func top(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        constraints.append(view.topAnchor.constraint(equalTo: anchor, constant: constant))
        return self
    }
    
    /// Adiciona constraint de bottom
    @discardableResult
    func bottom(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        constraints.append(view.bottomAnchor.constraint(equalTo: anchor, constant: constant))
        return self
    }
    
    /// Adiciona constraint de leading
    @discardableResult
    func leading(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        constraints.append(view.leadingAnchor.constraint(equalTo: anchor, constant: constant))
        return self
    }
    
    /// Adiciona constraint de trailing
    @discardableResult
    func trailing(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        constraints.append(view.trailingAnchor.constraint(equalTo: anchor, constant: constant))
        return self
    }
    
    /// Adiciona constraint de altura constante
    @discardableResult
    func height(_ constant: CGFloat) -> Self {
        constraints.append(view.heightAnchor.constraint(equalToConstant: constant))
        return self
    }
    
    /// Adiciona constraint de largura constante
    @discardableResult
    func width(_ constant: CGFloat) -> Self {
        constraints.append(view.widthAnchor.constraint(equalToConstant: constant))
        return self
    }
    
    /// Adiciona constraint de altura igual a outra view
    @discardableResult
    func height(equalTo anchor: NSLayoutDimension, multiplier: CGFloat = 1.0, constant: CGFloat = 0) -> Self {
        constraints.append(view.heightAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: constant))
        return self
    }
    
    /// Adiciona constraint de largura igual a outra view
    @discardableResult
    func width(equalTo anchor: NSLayoutDimension, multiplier: CGFloat = 1.0, constant: CGFloat = 0) -> Self {
        constraints.append(view.widthAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: constant))
        return self
    }
    
    /// Adiciona constraint de centerX
    @discardableResult
    func centerX(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> Self {
        constraints.append(view.centerXAnchor.constraint(equalTo: anchor, constant: constant))
        return self
    }
    
    /// Adiciona constraint de centerY
    @discardableResult
    func centerY(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> Self {
        constraints.append(view.centerYAnchor.constraint(equalTo: anchor, constant: constant))
        return self
    }
    
    /// Adiciona constraint customizada
    @discardableResult
    func add(_ constraint: NSLayoutConstraint) -> Self {
        constraints.append(constraint)
        return self
    }
    
    /// Ativa todas as constraints e retorna a view
    @discardableResult
    func activate() -> UIView {
        NSLayoutConstraint.activate(constraints)
        return view
    }
    
    /// Retorna apenas as constraints sem ativá-las
    func build() -> [NSLayoutConstraint] {
        return constraints
    }
}

// MARK: - UIView Extension
extension UIView {
    /// Método de conveniência para criar constraints usando o builder
    func makeConstraints(_ builder: (ConstraintBuilder) -> Void) {
        let constraintBuilder = ConstraintBuilder(view: self)
        builder(constraintBuilder)
        constraintBuilder.activate()
    }
    
    /// Método de conveniência para criar constraints e retornar a view
    @discardableResult
    func constraints(_ builder: (ConstraintBuilder) -> Void) -> UIView {
        let constraintBuilder = ConstraintBuilder(view: self)
        builder(constraintBuilder)
        return constraintBuilder.activate()
    }
}

// MARK: - Constraint Helpers
enum ConstraintAnchor {
    case top(NSLayoutYAxisAnchor, CGFloat = 0)
    case bottom(NSLayoutYAxisAnchor, CGFloat = 0)
    case leading(NSLayoutXAxisAnchor, CGFloat = 0)
    case trailing(NSLayoutXAxisAnchor, CGFloat = 0)
    case centerX(NSLayoutXAxisAnchor, CGFloat = 0)
    case centerY(NSLayoutYAxisAnchor, CGFloat = 0)
    case height(CGFloat)
    case width(CGFloat)
    case heightEqualTo(NSLayoutDimension, multiplier: CGFloat = 1.0, constant: CGFloat = 0)
    case widthEqualTo(NSLayoutDimension, multiplier: CGFloat = 1.0, constant: CGFloat = 0)
}

/// Helper para criar constraints de forma mais declarativa
struct ConstraintHelper {
    static func pinToEdges(
        _ view: UIView,
        to parentView: UIView,
        insets: UIEdgeInsets = .zero
    ) {
        view.makeConstraints { builder in
            builder
                .top(to: parentView.topAnchor, constant: insets.top)
                .leading(to: parentView.leadingAnchor, constant: insets.left)
                .trailing(to: parentView.trailingAnchor, constant: -insets.right)
                .bottom(to: parentView.bottomAnchor, constant: -insets.bottom)
        }
    }
    
    static func pinToSafeArea(
        _ view: UIView,
        to parentView: UIView,
        insets: UIEdgeInsets = .zero
    ) {
        guard let safeArea = parentView.superview?.safeAreaLayoutGuide else { return }
        view.makeConstraints { builder in
            builder
                .top(to: safeArea.topAnchor, constant: insets.top)
                .leading(to: parentView.leadingAnchor, constant: insets.left)
                .trailing(to: parentView.trailingAnchor, constant: -insets.right)
                .bottom(to: safeArea.bottomAnchor, constant: -insets.bottom)
        }
    }
    
    static func center(
        _ view: UIView,
        in parentView: UIView,
        offset: CGPoint = .zero
    ) {
        view.makeConstraints { builder in
            builder
                .centerX(to: parentView.centerXAnchor, constant: offset.x)
                .centerY(to: parentView.centerYAnchor, constant: offset.y)
        }
    }
    
    static func size(
        _ view: UIView,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) {
        view.makeConstraints { builder in
            if let width = width {
                builder.width(width)
            }
            if let height = height {
                builder.height(height)
            }
        }
    }
}
