//
//  Programmatic.swift
//  CarouselTest
//
//  Created by David Schmöcker on 05.11.21.
//

import UIKit

public protocol Programmatic: AnyObject {
    var isSetup: Bool { get set }

    func setupIfNecessary()
    func setupUI()
}

public extension Programmatic {
    func setupIfNecessary() {
        if !isSetup {
            setupUI()
            isSetup = true
        }
    }
}

class ProgrammaticCollectionViewCell: UICollectionViewCell, Programmatic {
    public var isSetup: Bool = false

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupIfNecessary()
    }

    public override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setupIfNecessary()
    }

    public init() {
        super.init(frame: CGRect.zero)
        setupIfNecessary()
    }

    func setupUI() {
        print("⚠️ WARNING: setupUI() not overwritten by subclass of ProgrammaticCollectionViewCell (\(Self.self))")
    }
}

open class ProgrammaticCollectionReusableView: UICollectionReusableView, Programmatic {
    public var isSetup: Bool = false

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupIfNecessary()
    }

    public override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setupIfNecessary()
    }

    public init() {
        super.init(frame: CGRect.zero)
        setupIfNecessary()
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        setupIfNecessary()
    }

    open func setupUI() {
        print("⚠️ WARNING: setupUI() not overwritten by subclass of ProgrammaticCollectionReusableView (\(Self.self))")
    }
}
