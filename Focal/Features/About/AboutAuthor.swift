//
//  AboutAuthor.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 22/10/2026.
//

import SwiftUI

struct AboutAuthor: View {
    private let socialLinks: [SocialLink] = [
        SocialLink(
            name: "GitHub",
            url: URL(string: "https://www.github.com/cross19xx")!,
            image: "Social/Github",
            handle: "@cross19xx"
        ),
        SocialLink(
            name: "LinkedIn",
            url: URL(string: "https://www.linkedin.com/in/kenneth-kwakye-gyamfi")!,
            image: "Social/Linkedin"
        ),
        SocialLink(
            name: String(localized: "Email"),
            url: URL(string: "mailto:kenneth.cross95@gmail.com")!,
            systemImage: "envelope.fill"
        ),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            SectionLabel(String(localized: "Made by"))
                .padding(.leading, 4)

            VStack {
                HStack(spacing: 14) {
                    Circle()
                        .fill(.background.secondary)
                        .frame(width: 56, height: 56)

                    VStack(alignment: .leading, spacing: 3) {
                        Text(verbatim: "Kenneth Kwakye-Gyamfi")
                            .font(.body.weight(.semibold))

                        Text(String(localized: "about.bio", table: "About"))
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity, alignment: .leading)

                ForEach(socialLinks) { link in
                    Divider()
                    Link(destination: link.url) {
                        HStack(alignment: .center, spacing: 12) {
                            if let image = link.image {
                                Image(image)
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    // This will only affect the template images. i.e. Github
                                    .foregroundStyle(.primary)
                            }

                            if let image = link.systemImage {
                                Image(systemName: image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                            }

                            Text(link.name)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            if let handle = link.handle {
                                Text(handle)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 14)
                        .padding(.horizontal, 16)
                    }
                    .buttonStyle(.plain)
                }
            }
            .background(.background.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct SocialLink: Identifiable {
    let name: String
    let url: URL
    var image: String?
    var systemImage: String?
    var handle: String?
    var id: String { name }
}

#if DEBUG
#Preview("Light") {
    AboutAuthor()
}

#Preview("Dark") {
    AboutAuthor()
        .preferredColorScheme(.dark)
}
#endif
