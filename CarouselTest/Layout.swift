//
//  MagicLayout.swift
//  CarouselTest
//
//  Created by David Schmöcker on 05.11.21.
//

import UIKit


struct Layout {
    public static let footerKind = "CarouselPageControlFooter"
    public static let headerKind = "SectionHeader"
    private static let footerIdentifier = "CarouselPageControlFooter"
    private static let headerIdentifier = "SectionHeader"

    public static func makeLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            return Layout.carouselLayoutProvider(sectionIndex, layoutEnvironment)

        }, configuration: configuration)

        return layout
    }

    public static func registerViews(on collectionView: UICollectionView) {
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: "CarouselCell")
        collectionView.register(CarouselPageControlFooter.self,
                                forSupplementaryViewOfKind: "CarouselPageControlFooter",
                                withReuseIdentifier: footerKind)
        collectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: headerKind,
                                withReuseIdentifier: "SectionHeader")
    }

    static let carouselLayoutProvider: UICollectionViewCompositionalLayoutSectionProvider = { (_, layoutEnvironment) -> NSCollectionLayoutSection? in
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(CarouselCell.defaultHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(layoutEnvironment.container.contentSize.width),
                                               heightDimension: .absolute(CarouselCell.defaultHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .paging

        section.boundarySupplementaryItems = [getSectionHeaderLayoutItem(estimatedHeight: 20.0),
                                              getCarouselFooterLayoutItem()]
//        section.boundarySupplementaryItems = [getCarouselFooterLayoutItem()]
        section.contentInsets.top = 10

        return section
    }

    private static func getCarouselFooterLayoutItem(offset: CGPoint = CGPoint.zero,
                                                    elementKind: String = footerKind) -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .absolute(36.0))
        let footer = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: size,
                                                                 elementKind: elementKind,
                                                                 alignment: .bottom,
                                                                 absoluteOffset: offset)
        return footer
    }

    private static func getSectionHeaderLayoutItem(estimatedHeight: CGFloat,
                                                   offset: CGPoint = CGPoint.zero,
                                                   elementKind: String = headerKind) -> NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                          heightDimension: .estimated(estimatedHeight))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: size,
                                                                 elementKind: elementKind,
                                                                 alignment: .top,
                                                                 absoluteOffset: offset)
        return header
    }

    public static func getCarouselControlFooter(delegate: CarouselPageControlFooterDelegate?,
                                                for collectionView: UICollectionView,
                                                at indexPath: IndexPath) -> CarouselPageControlFooter {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: footerKind, withReuseIdentifier: footerIdentifier, for: indexPath)

        guard let pageControlFooter = footer as? CarouselPageControlFooter else {
            fatalError("Unable to cast dequed cell to expected type CarouselPageControlFooter")
        }

        pageControlFooter.delegate = delegate

        return pageControlFooter
    }

    public static func getSectionHeader(withTitle title: String, for collectionView: UICollectionView, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: headerKind, withReuseIdentifier: headerIdentifier, for: indexPath)

        guard let header = view as? SectionHeader else {
            return view
        }

        header.title = title

        return header
    }
}
