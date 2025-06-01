//
//  MovieGridViewController.swift
//  Watchly
//
//  Created by Vinsi on 31/05/2025.
//

import TMDBCore
import UIKit

class MovieGridViewController: UICollectionViewController {
    private var movies: [Movie] = []

    init() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
        let columns: CGFloat = 2
        let width = (UIScreen.main.bounds.width - (columns + 1) * spacing) / columns

        layout.itemSize = CGSize(width: width, height: width * 1.8)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)

        super.init(collectionViewLayout: layout)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        loadMockData()
    }

    private func loadMockData() {

        collectionView.reloadData()
    }

    // MARK: DataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as? MovieCell
        cell?.configure(with: movies[indexPath.item])
        return cell ?? UICollectionViewCell()
    }
}

import SwiftUI
import UIKit

struct MovieGridViewRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        return MovieGridViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // No update needed for now
    }
}
