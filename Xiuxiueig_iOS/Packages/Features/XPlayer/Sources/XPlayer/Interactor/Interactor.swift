// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation
import struct XEntities.LectureEntity

final class Interactor: InteractorInput {

    var output: InteractorOutput?
    let services: XPlayerServiceInterface
    let audioEngineBuider: AudioEngineInterfaceBuilder

    init(services: XPlayerServiceInterface,
         audioEngineBuider: AudioEngineInterfaceBuilder) {

        self.services = services
        self.audioEngineBuider = audioEngineBuider
    }

    // MARK: - Intercator input

    func request(_ event: InteractorEvents.Input) async {

        switch event {

        case .loadInitialData:
            if currentLecture == nil {
                await loadNextLecture()
            }
        case .playToggle:
            await onPlayPause()
        case .skipForward:
            onSkipForwards()
        case .skipBackwards:
            onSkipBackwards()
        }
    }

    // MARK: - Intercator output

    func render(_ event: InteractorEvents.Output) {

        DispatchQueue.main.async {

            self.output?.dispatch(event)
        }
    }

    // MARK: - Error

    private func renderError(_ error: Error, retryAction: (() -> Void)? = nil) {
        // Work with interactor and the SnackBar.
    }

    // MARK: - Action

    private var currentLecture: XPlayerLecture?
    private var currentEngine: AudioEngineInterface?

    private func loadNextLecture() async {

        render(.startLoading)

        do {
            guard let lecture = try await services.nextLecture()
            else {
                render(.noLecture)
                currentEngine = nil
                currentLecture = nil
                return
            }

            let audioEngine = try audioEngineBuider.build(with: lecture.mediaURL,
                                                          onPlaybackRefresh: enginePlaybackUpdate,
                                                          onDone: engineDone)

            let data = InteractorEvents.Output.LectureData(lecture: lecture,
                                                           audio: audioEngine.info())
            render(.refresh(data))

            currentLecture = lecture
            currentEngine = audioEngine

        } catch {

            renderError(error)
        }
    }

    func enginePlaybackUpdate(audioInfo: AudioInfo) {

        guard let lecture = currentLecture
        else { return }

        let data = InteractorEvents.Output.LectureData(lecture: lecture,
                                                       audio: audioInfo)
        render(.refresh(data))
    }

    func engineDone() {
        Task {
            await onPlaybackDone()
        }
    }

    func onPlaybackDone() async {

        guard let lecture = currentLecture
        else { return }

        do {
            try await services.donePlaying(id: lecture.id)
            await loadNextLecture()
            // If autoplay.
            await onPlayPause()
        } catch {
            // Show error to the user?
        }
    }

    private func onPlayPause() async {

        guard let engine = currentEngine,
              let lecture = currentLecture
        else { return }

        engine.playToggle()
        let info = engine.info()
        let data = InteractorEvents.Output.LectureData(lecture: lecture,
                                                       audio: info)
        render(.refresh(data))

        if info.isPlaying {
            await services.playing(id: lecture.id, in: info.currentPositionInSeconds)
        } else {
            await services.paused(id: lecture.id, in: info.currentPositionInSeconds)
        }
    }

    private func onSkipForwards() {

        currentEngine?.seek(to: 10)
    }

    private func onSkipBackwards() {

        currentEngine?.seek(to: -10)
    }
}

private extension Interactor {

}
