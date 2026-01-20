//
//  ScrollableVideoView.swift
//  SwiftUI-Snippets
//
//  Created by Asim on 20/11/2025.
//

import SwiftUI
import AVKit


struct ScrollableVideoView: View {
    
    
    // MARK: PROPERTIES
    let videos = DisplayVideo.mockVideos
    @State var activeVideo: DisplayVideo?
    
    
    // MARK: Body
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                ForEach(videos) { video in
                    VideoPlayer(player: video.player)
                        .scaledToFill()
                        .containerRelativeFrame(.vertical)
                        .id(video)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
        .scrollPosition(id: $activeVideo)
        .onChange(of: activeVideo) { previous, current in
            current?.player.play()
            previous?.player.pause()
        }
        .onAppear {
            activeVideo = videos.first
        }
    }
    
}


// MARK: DisplayVideo
struct DisplayVideo: Identifiable, Hashable, Equatable {
    let id: UUID
    let url: URL
    let player: AVPlayer
    
    init(id: UUID = UUID(), url: URL) {
        self.id = id
        self.url = url
        self.player = AVPlayer(url: url)
    }
    
    static let mockVideos: [DisplayVideo] = {
        var videos: [DisplayVideo] = []
        for _ in 0...5 {
            videos.append(.init(url: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")!))
        }
        return videos
    }()
}

#Preview {
    ScrollableVideoView()
}
