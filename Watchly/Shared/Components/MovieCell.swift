//
//  MovieCell.swift
// 
//
//  Created by Vinsi.
//

import SwiftUI

struct ImageHelper: View {
    var url: URL?
    var theme: Theme

    @ViewBuilder
    private func noImage() -> some View {
        Image(systemName: theme.images.placeHolderSystemIcon)
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray)
    }

    var body: some View {

        RemoteImage(
            url: url
        )
        .frame(width: theme.dimensions.thumbSize.width, height: theme.dimensions.thumbSize.height)
        .background(Color.gray.opacity(0.2))
        .clipShape(RoundedRectangle(cornerRadius: theme.dimensions.cornerRadius))
    }
}

struct MovieCell: View {
    let viewData: ListViewDataType
    let theme: Theme

    var body: some View {
        VStack(spacing: theme.spacing.medium) {
            HStack(alignment: .top, spacing: theme.spacing.medium) {
                ImageHelper(url: viewData.posterImage, theme: theme)

                VStack(alignment: .leading, spacing: theme.spacing.small) {
                    Text(viewData.title)
                        .font(theme.typography.cellMedium)
                        .foregroundColor(theme.colors.textPrimary)

                    Text(viewData.shortDescription)
                        .font(theme.typography.cellSmall)
                        .foregroundColor(theme.colors.textSecondary)
                        .lineLimit(1)
                        .truncationMode(.tail)

                    HStack {
                        Text(viewData.releaseDate ?? "")
                            .font(theme.typography.cellSmall)
                            .foregroundColor(theme.colors.textSecondary)

                        Spacer()

                    }
                }
            }

            HStack {
                Text(viewData.shortDescription)
                    .font(theme.typography.cellMedium)
                    .foregroundColor(theme.colors.textSecondary)
                Spacer()
            }
        }
        .padding([.top, .bottom], theme.spacing.small)
    }
}

#Preview {
    MovieCell(viewData: Movie.mock(), theme: DefaultTheme())
}
