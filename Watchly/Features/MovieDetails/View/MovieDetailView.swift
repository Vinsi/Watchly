//
//  MovieDetailView.swift
//  Watchly
//
//  Created by Vinsi on 30/05/2025.
//

import SwiftUI
import TMDBCore

struct MovieDetailView: View {
    @EnvironmentObject var environment: AppEnvironment
    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: MovieDetailViewModel
    @State var hasError: Bool = false
    init(useCase: DetailUseCaseType, movieID: Int) {
        _viewModel = StateObject(wrappedValue: MovieDetailViewModel(useCase: useCase, movieID: movieID))
    }

    var body: some View {
        ScrollView {
            switch viewModel.sections {
            case .success(let detailSection):

                VStack(alignment: .leading, spacing: 16) {
                    ForEach(detailSection, id: \.id) { section in
                        section.getContent(using: themeManager.currentTheme)
                    }
                }

            case .fetching:

                HUDLoaderView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)

            default:
                EmptyView()
            }
        }.task {
            viewModel.fetchDetails()
        }
        .navigationTitle(Localized.detailTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            toolBar()
        }
    }

    @ToolbarContentBuilder
    private func toolBar() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(
                action: {
                    presentationMode.wrappedValue.dismiss()
                },
                label: {
                    HStack {
                        Image(themeManager.currentTheme.images.backIcon)
                    }
                }
            )
        }
    }
}

extension DetailSection {

    @ViewBuilder func getContent(using theme: Theme) -> some View {
        switch self {
        case .posterBackDrop(let movieID, .some(let imagePath)):
            posterBackdrop(movieID, imagePath, theme: theme)
        case .posterBackDrop(_, .none):
            Spacer().frame(height: 8)
        case .posterImage(let poster):
            posterImage(posterAttribute: poster, theme: theme)
        case .overview(let summary):
            overview(title, movieTitle: summary, theme: theme)
        case .genres(let genres):
            genre(title, genres: genres, theme: theme)
        case .details(let attributes):
            details(title: title, attributes, theme: theme)
        case .link(.some(let url)):
            link(linkTitle: title, link: url, theme: theme)
        default: EmptyView()
        }
    }

    @ViewBuilder
    private func posterBackdrop(_ movieID: Int, _ image: TMDBImage, theme: Theme) -> some View {
        ZStack(alignment: .bottomTrailing) {
            TMDBRemoteImage(url: image)
                .frame(height: 250)
                .clipped()

            FavoritesButton(movieID: movieID).padding([.bottom, .trailing], theme.spacing.medium)
        }
    }

    @ViewBuilder
    private func posterImage(posterAttribute: PosterAttributes, theme: Theme) -> some View {
        HStack(alignment: .top, spacing: theme.spacing.medium) {
            TMDBRemoteImage(url: posterAttribute.poster)
                .frame(width: 120, height: 180)
                .cornerRadius(theme.dimensions.cornerRadius)

            VStack(alignment: .leading, spacing: theme.spacing.small) {

                Text(posterAttribute.movieTitle)
                    .font(theme.typography.title)

                if let tagLine = posterAttribute.tagLine {
                    Text(tagLine)
                        .font(theme.typography.body)
                        .foregroundColor(theme.colors.textSecondary)
                }

                Text(posterAttribute.votes)
                    .font(theme.typography.body)
                    .foregroundColor(theme.colors.primary)

                Spacer()
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func overview(_ title: String, movieTitle: String, theme: Theme) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.small) {
            Text(title)
                .font(.headline)
            Text(movieTitle)
                .font(theme.typography.body)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func genre(_ title: String, genres: [Genre], theme: Theme) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.small) {

            Text(title)
                .font(.headline)

            WrapHStack(data: genres, spacing: theme.spacing.small) { genre in
                Text(genre.name)
                    .font(.caption)
                    .padding(.horizontal, theme.spacing.small)
                    .padding(.vertical, theme.spacing.vsmall)
                    .foregroundColor(theme.colors.secondary)
                    .background(theme.colors.primary.opacity(0.8))
                    .cornerRadius(theme.dimensions.cornerRadius)
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func details(title: String, _ attributes: [(title: String, value: String)], theme: Theme) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.small) {
            Text(title)
                .font(.headline)
            ForEach(attributes, id: \.0) { attribute in
                AttributeRow(attribute: attribute.title, value: attribute.value)
            }
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    private func link(linkTitle: String, link: URL, theme: Theme) -> some View {
        VStack(alignment: .leading, spacing: theme.spacing.small) {
            Link(destination: link) {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: 1,
                            dash: [6] // For dotted/dashed style
                        )
                    )
                    .foregroundColor(theme.colors.textSecondary.opacity(0.4))
                    .overlay {
                        Text(linkTitle)
                            .font(theme.typography.cellTitleLarge).bold()
                            .foregroundColor(theme.colors.primary)
                            .padding()
                    }
            }
            .frame(maxWidth: .infinity, minHeight: 50)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
    }
}

struct AttributeRow: View {
    let attribute: String
    @EnvironmentObject private var theme: ThemeManager
    let value: String?

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(attribute)
                .font(theme.currentTheme.typography.mediumTitle)
            Spacer()
            Text(value ?? "")
                .font(theme.currentTheme.typography.mediumTitle)
                .multilineTextAlignment(.trailing)
                .foregroundColor(theme.currentTheme.colors.primary)
        }
    }
}
