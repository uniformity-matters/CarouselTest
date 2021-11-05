//
//  ViewController.swift
//  CarouselTest
//
//  Created by David Schmöcker on 05.11.21.
//

import UIKit

class ViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var controlFooter: CarouselPageControlFooter?

    private var movingToPage: Int?

    override open func loadView() {
        let customView = setupUI(frame: CGRect(x: 0,
                                               y: 0,
                                               width: UIScreen.main.bounds.width,
                                               height: UIScreen.main.bounds.height))
        self.view = customView
    }

    func setupUI(frame: CGRect) -> UIView {
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .systemGray

        Layout.registerViews(on: collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self

        self.collectionView = collectionView

        return collectionView
    }

    func createLayout() -> UICollectionViewLayout {
        return Layout.makeLayout()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.identifier, for: indexPath)
        guard let carouselCell = cell as? CarouselCell else {
            return cell
        }

        let colors: [UIColor] = [.red, .blue, .green, .magenta, .cyan]
        carouselCell.backgroundColor = colors[indexPath.row]

        return carouselCell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case Layout.footerKind:
            let footer = Layout.getCarouselControlFooter(delegate: self,
                                                         for: collectionView,
                                                         at: indexPath)
            footer.numberOfPages = 5
            footer.currentPage = 0

            self.controlFooter = footer

            return footer
        case Layout.headerKind:
            return Layout.getSectionHeader(withTitle: "Section Header", for: collectionView, at: indexPath)
        default:
            fatalError("Requested supplementary view for unexpected kind: \(kind)")
        }
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print("willDisplayCell: \(indexPath)")
        movingToPage = indexPath.row
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        print("didEndDisplayingCell: \(indexPath)")
        // Moving aborted
        if indexPath.row == movingToPage {
            movingToPage = nil
        }

        // Moving completed
        if indexPath.row == controlFooter?.currentPage {
            if let movingToPage = movingToPage {
                controlFooter?.currentPage = movingToPage
            }
        }
    }
}

extension ViewController: CarouselPageControlFooterDelegate {
    func didSelectPage(_ page: Int) {
        let indexPath = IndexPath(item: page, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}
