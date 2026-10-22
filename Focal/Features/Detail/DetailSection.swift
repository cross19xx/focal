//
//  DetailSection.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 22/10/2026.
//

import SwiftUI

struct DetailSection: View {
    let title: String
    let description: String
    var withLeadingBar = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title.uppercased())
                .font(.footnote.weight(.semibold))
                .tracking(0.6)
                .foregroundStyle(.secondary)

            if withLeadingBar {
                MarkdownText(description)
                    .font(.callout)
                    .padding(.vertical, 2)
                    .padding(.leading, 15)
                    .background(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 2)
                            .fill(Color.accentColor)
                            .frame(width: 3)
                    }
            } else {
                MarkdownText(description)
                    .font(.callout)
            }
        }
    }
}

#if DEBUG
private let sampleParagraph = """
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce augue purus, ultricies ut libero et, \
    lobortis euismod magna. Duis ut faucibus ipsum. Nam nisi libero, pulvinar nec purus at, ullamcorper \
    varius quam. Cras turpis tortor, facilisis ut faucibus quis, hendrerit sed magna.
    """

#Preview("Light", traits: .sizeThatFitsLayout) {
    DetailSection(title: "Description", description: sampleParagraph)
}

#Preview("Dark", traits: .sizeThatFitsLayout) {
    DetailSection(title: "Description", description: sampleParagraph)
        .preferredColorScheme(.dark)
}

#Preview("Light (with bar)", traits: .sizeThatFitsLayout) {
    DetailSection(title: "Inspiration", description: sampleParagraph, withLeadingBar: true)
}

#Preview("Dark (with bar)", traits: .sizeThatFitsLayout) {
    DetailSection(title: "Inspiration", description: sampleParagraph, withLeadingBar: true)
        .preferredColorScheme(.dark)
}
#endif
