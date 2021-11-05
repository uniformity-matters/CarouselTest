//
//  SectionHeader.swift
//  CarouselTest
//
//  Created by David Schmöcker on 05.11.21.
//

import UIKit

public class SectionHeader: ProgrammaticCollectionReusableView {
    internal var titleLabel: UILabel!

    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    override open func setupUI() {
        setupLabels(in: self)
    }

    fileprivate func setupLabels(in container: UIView) {
        let titleLabel = UILabel()
        container.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: container.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 8.0),
            titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8.0)
        ])

        backgroundColor = .systemGray3
        self.titleLabel = titleLabel
    }
}
