import SwiftUI
import AVKit
import Combine

struct VisibilityPreferenceKey: PreferenceKey {
    static let defaultValue: [UUID: CGFloat] = [:]
    static func reduce(value: inout [UUID: CGFloat], nextValue: () -> [UUID: CGFloat]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}

final class PlaybackManager: ObservableObject {
    static let shared = PlaybackManager()

    private var players: [UUID: AVPlayer] = [:]
    @Published private var mostVisiblePlayerID: UUID?
    private var cancellables = Set<AnyCancellable>()
    private let playerQueue = DispatchQueue(label: "com.volindo.test", qos: .userInteractive)

    private init() {}

    deinit {
        cancellables.forEach { $0.cancel() }
    }

    func register(id: UUID, player: AVPlayer) {
        playerQueue.async { [weak self] in
            guard let self = self else { return }
            self.players[id] = player
            if self.players.count == 1 {
                self.playPlayer(for: id) // Use helper method
            }
        }
    }

    func unregister(id: UUID) {
        playerQueue.async { [weak self] in
            guard let self = self else { return }
            self.pausePlayer(for: id)  // Use helper method
            self.players.removeValue(forKey: id)
        }
    }

    func updateVisibility(_ vis: [UUID: CGFloat]) {
        playerQueue.async { [weak self] in //update on the queue
            guard let self = self else { return }
            let bestEntry = vis.max { $0.value < $1.value }
            let bestID = bestEntry?.key
            let bestVisibility = bestEntry?.value ?? 0

            if bestVisibility > 0.5 {
                if self.mostVisiblePlayerID != bestID { // Only update if different
                    self.mostVisiblePlayerID = bestID //update on main thread
                    self.handlePlayback()
                }
            } else if self.mostVisiblePlayerID != nil{
                self.mostVisiblePlayerID = nil
                self.handlePlayback()
            }
        }
    }

    private func handlePlayback() {
        DispatchQueue.main.async { //switch to main
            self.players.forEach { id, player in
                if id == self.mostVisiblePlayerID {
                    self.playPlayer(for: id)
                } else {
                    self.pausePlayer(for: id)
                }
            }
        }
    }

    private func playPlayer(for id: UUID) {
        guard let player = players[id] else { return }
        player.play()
        player.isMuted = false
    }

    private func pausePlayer(for id: UUID) {
        guard let player = players[id] else { return }
        player.pause()
    }
}
