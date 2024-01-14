//
//  EditorInlineScreen.swift
//  Demo (macOS)
//
//  Created by Daniel Saidi on 2022-06-06.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import RichTextKit
import SwiftUI

struct EditorInlineScreen: View {

    init() {
        // RichTextEditor.standardRichTextFontSize = 100
    }

    @State
    private var text = NSAttributedString.empty

    @StateObject
    var context = RichTextContext()

    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack(spacing: 0) {
                Text("123")
                Divider()
                toolbar
            }
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                RichTextActionButtonStack(
                    context: context,
                    actions: [.undo, .redo, .copy]
                )
            }
        }
        .viewDebug()
    }
}

private extension EditorInlineScreen {

    var editor: some View {
        ZStack {
            Color.red
            
            List {
                RichTextEditor(text: $text, context: context) {
                    $0.textContentInset = CGSize(width: 10, height: 20)
                }
                .onAppear {
                    context.scrollingDisabled = true
                }
                .frame(minWidth: 400)
                .focusedValue(\.richTextContext, context)
            }
           
        }
       
    }

    var toolbar: some View {
        RichTextFormatSidebar(
            context: context,
            colorPickers: .all
        )
        .frame(width: 250)
    }
}

struct EditorInlineScreen_Previews: PreviewProvider {

    static var previews: some View {
        EditorScreen()
    }
}
