//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by CS193p Instructor on 4/26/21.
//  Copyright © 2021 Stanford University. All rights reserved.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    
    let defaultEmojiFontSize: CGFloat = 40
    
    var body: some View {
        VStack(spacing: 0) {
            documentBody
            palette
        }
    }
    var documentBody: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.overlay(
                    OptionalImage(uiImage: document.backgroundImage)
                        .scaleEffect(zoomScale)
                        .position(convertFromEmojiCoordinates((0,0), in: geometry))
                )
                .gesture(doubleTapToZoom(in: geometry.size)
                            .exclusively(before: singleTapRemove()))
                if document.backgroundImageFetchStatus == .fetching {
                    ProgressView().scaleEffect(2)
                } else {
                    
                    ForEach(document.emojis) { emoji in
                        Text(emoji.text)
                            .font(.system(size: fontSize(for: emoji)))
                            .overlay(selectedEmojis.contains(emoji) ? RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 1) : RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0))
                            .scaleEffect(selectedEmojis.contains(emoji) ? emojiGestureZoomScale * zoomScale : zoomScale)
                            .position(position(for: emoji, in: geometry))
                            .offset(selectedEmojis.contains(emoji) ? emojiPanGestureOffset * zoomScale : CGSize(width: 0, height: 0))
                            .gesture(emojiScaleGesture().simultaneously(with: emojiPanGesture().exclusively(before: doubleTapToRemove(emoji: emoji).exclusively(before: tapToSelect(emoji: emoji)))))
                    }
                }
            }
            .clipped()
            .onDrop(of: [.plainText,.url,.image], isTargeted: nil) { providers, location in
                drop(providers: providers, at: location, in: geometry)
            }
            .gesture(isThereSelection ? emojiScaleGesture(): nil)
            .gesture(isThereSelection ? nil : zoomGesture().simultaneously(with: panGesture()))
        }
    }
    
    // MARK: - Selecting Emoji
    @State var selectedEmojis: Set<EmojiArtModel.Emoji>
    
    private var isThereSelection: Bool {
        return selectedEmojis.count > 0
    }
    @GestureState var emojiGestureZoomScale = CGFloat(1.0)

    private func emojiScaleGesture() -> some Gesture {
        MagnificationGesture()
            .updating($emojiGestureZoomScale) { latestGestureScale, emojiGestureZoomScale, _ in
                emojiGestureZoomScale = latestGestureScale
            }
            .onEnded { gestureScaleAtEnd in
                for emoji in document.emojis {
                    if selectedEmojis.contains(emoji) {
                        document.scaleEmoji(emoji, by: gestureScaleAtEnd)
                    }
                }
                unselectAll()
            }
    }
    
    
    @GestureState private var emojiPanGestureOffset: CGSize = CGSize.zero
    @State private var latestEmojiPanOffset = CGSize.zero
    
    private func emojiPanGesture() -> some Gesture {
        DragGesture()
            .updating($emojiPanGestureOffset) { latestDragGestureValue, emojiGesturePanOffset, _ in
                emojiGesturePanOffset = latestDragGestureValue.translation / zoomScale
            }
            .onEnded { finalDragGestureValue in
                for emoji in document.emojis {
                    if selectedEmojis.contains(emoji) {
                        document.moveEmoji(emoji, by: (finalDragGestureValue.translation / zoomScale))
                    }
                }
                unselectAll()
            }
    }
    
    private func tapToSelect(emoji: EmojiArtModel.Emoji) -> some Gesture {
        TapGesture(count: 1)
            .onEnded {
                withAnimation {
                    selectedEmojis.toggleMembership(of: emoji)
                    print("Emoji id \(emoji.text) toggled")
                }
            }
    }
    
    private func doubleTapToRemove(emoji: EmojiArtModel.Emoji) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    document.removeEmoji(emoji.id)
                    unselectAll()
                }
            }
    }
    
    private func unselectAll() {
        selectedEmojis = Set<EmojiArtModel.Emoji>()
    }
    
    private func singleTapRemove() -> some Gesture {
        TapGesture(count: 1)
            .onEnded {
                withAnimation {
                    unselectAll()
                }
            }
    }

    // MARK: - Drag and Drop
    
    private func drop(providers: [NSItemProvider], at location: CGPoint, in geometry: GeometryProxy) -> Bool {
        var found = providers.loadObjects(ofType: URL.self) { url in
            document.setBackground(.url(url.imageURL))
        }
        if !found {
            found = providers.loadObjects(ofType: UIImage.self) { image in
                if let data = image.jpegData(compressionQuality: 1.0) {
                    document.setBackground(.imageData(data))
                }
            }
        }
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                if let emoji = string.first, emoji.isEmoji {
                    document.addEmoji(
                        String(emoji),
                        at: convertToEmojiCoordinates(location, in: geometry),
                        size: defaultEmojiFontSize / zoomScale
                    )
                }
            }
        }
        return found
    }
    
    // MARK: - Positioning/Sizing Emoji
    
    private func position(for emoji: EmojiArtModel.Emoji, in geometry: GeometryProxy) -> CGPoint {
        convertFromEmojiCoordinates((emoji.x, emoji.y), in: geometry)
    }
    
    private func fontSize(for emoji: EmojiArtModel.Emoji) -> CGFloat {
        CGFloat(emoji.size)
    }
    
    private func convertToEmojiCoordinates(_ location: CGPoint, in geometry: GeometryProxy) -> (x: Int, y: Int) {
        let center = geometry.frame(in: .local).center
        let location = CGPoint(
            x: (location.x - panOffset.width - center.x) / zoomScale,
            y: (location.y - panOffset.height - center.y) / zoomScale
        )
        return (Int(location.x), Int(location.y))
    }
    
    private func convertFromEmojiCoordinates(_ location: (x: Int, y: Int), in geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(
            x: center.x + CGFloat(location.x) * zoomScale + panOffset.width,
            y: center.y + CGFloat(location.y) * zoomScale + panOffset.height
        )
    }
    
    // MARK: - Zooming
    
    @State private var steadyStateZoomScale: CGFloat = 1
    @GestureState private var gestureZoomScale: CGFloat = 1
    

    
    private var zoomScale: CGFloat {
        steadyStateZoomScale * gestureZoomScale
    }
    

    private func zoomGesture() -> some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, _ in
                gestureZoomScale = latestGestureScale
            }
            .onEnded { gestureScaleAtEnd in
                steadyStateZoomScale *= gestureScaleAtEnd
            }
    }
    

    private func doubleTapToZoom(in size: CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    zoomToFit(document.backgroundImage, in: size)
                }
            }
    }
    
    private func zoomToFit(_ image: UIImage?, in size: CGSize) {
        if let image = image, image.size.width > 0, image.size.height > 0, size.width > 0, size.height > 0  {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            steadyStatePanOffset = .zero
            steadyStateZoomScale = min(hZoom, vZoom)
        }
    }
    
    // MARK: - Panning
    
    @State private var steadyStatePanOffset: CGSize = CGSize.zero
    @GestureState private var gesturePanOffset: CGSize = CGSize.zero
    
    private var panOffset: CGSize {
        (steadyStatePanOffset + gesturePanOffset) * zoomScale
        
    }
    
    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, _ in
                gesturePanOffset = latestDragGestureValue.translation / zoomScale
            }
            .onEnded { finalDragGestureValue in
                steadyStatePanOffset = steadyStatePanOffset + (finalDragGestureValue.translation / zoomScale)
            }
    }

    // MARK: - Palette
    
    var palette: some View {
        ScrollingEmojisView(emojis: testEmojis)
            .font(.system(size: defaultEmojiFontSize))
    }
    
    let testEmojis = "😀😷🦠💉👻👀🐶🌲🌎🌞🔥🍎⚽️🚗🚓🚲🛩🚁🚀🛸🏠⌚️🎁🗝🔐❤️⛔️❌❓✅⚠️🎶➕➖🏳️"
}

struct ScrollingEmojisView: View {
    
    let emojis: String

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis.map { String($0) }, id: \.self) { emoji in
                    Text(emoji)
                        .onDrag { NSItemProvider(object: emoji as NSString) }
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        EmojiArtDocumentView(document: EmojiArtDocument(), selectedEmojis: [])
//    }
//}
