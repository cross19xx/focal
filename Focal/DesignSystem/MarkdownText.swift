//
//  MarkdownText.swift
//  Focal
//
//  Created by Kenneth Kwakye-Gyamfi on 22/10/2026.
//

import SwiftUI

struct MarkdownText: View {
    let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text((try? AttributedString(inlineMarkdown: text)) ?? AttributedString(text))
    }
}

extension AttributedString {
    /// The project's Markdown fields are inline only; blank lines must survive as paragraph breaks.
    init(inlineMarkdown text: String) throws {
        try self.init(
            markdown: text,
            options: MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        )
    }
}

#if DEBUG
#Preview("Light", traits: .sizeThatFitsLayout) {
    MarkdownText("**Lorem ipsum** dolor sit amet, _consectetur adipiscing elit_.\n\nFusce `augue purus`, ultricies ut libero.")
}

#Preview("Dark", traits: .sizeThatFitsLayout) {
    MarkdownText("**Lorem ipsum** dolor sit amet, _consectetur adipiscing elit_.\n\nFusce `augue purus`, ultricies ut libero.")
        .preferredColorScheme(.dark)
}
#endif
