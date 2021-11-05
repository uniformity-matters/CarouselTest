//
//  CarouselPageFooter.swift
//  CarouselTest
//
//  Created by David Schmöcker on 05.11.21.
//

import UIKit

public class CarouselPageControlFooter: ProgrammaticCollectionReusableView {
    public static let identifier = "CarouselPageControlFooter"
    private var pageControl: UIPageControl!

    public weak var delegate: CarouselPageControlFooterDelegate?

    public var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = self.currentPage
        }
    }

    public var numberOfPages: Int = 0 {
        didSet {
            pageControl.numberOfPages = self.numberOfPages
        }
    }

    override public func setupUI() {
        let pageControl = UIPageControl()
        self.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 28.0),
            pageControl.topAnchor.constraint(equalTo: self.topAnchor, constant: 4.0),
            pageControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4.0)
        ])

        pageControl.pageIndicatorTintColor = .black
        pageControl.currentPageIndicatorTintColor = .white

        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)

        self.backgroundColor = .systemGray3

        self.pageControl = pageControl
    }

    @objc
    private func pageControlValueChanged() {
        if pageControl.currentPage != currentPage {
            delegate?.didSelectPage(pageControl.currentPage)
        }
    }
}

public protocol CarouselPageControlFooterDelegate: AnyObject {
    func didSelectPage(_ page: Int)
}
