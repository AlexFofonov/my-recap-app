//
//  MainViewModel.swift
//
//  AlexFofonov in 2024
//

import SwiftData
import SwiftUI

enum MainViewEvent: BaseViewEvent {
    case setup(
        router: Router?,
        resumeModelQuery: [ResumeModel],
        modelContext: ModelContext?
    )

    case onEditResume
    case onDeleteResume

    case clipLink(contactId: UUID)
}

struct MainViewState: BaseViewState {
    init(resume: Resume = .init()) {
        self.resume = resume
    }

    var resume: Resume
}

protocol MainViewModel: BaseViewModel where ViewState == MainViewState, ViewEvent == MainViewEvent {}

final class MainViewModelImp: MainViewModel {
    init(
        state: MainViewState = .init(),
        router: Router? = nil,
        modelContext: ModelContext? = nil
    ) {
        self.state = state
        self.router = router
        self.modelContext = modelContext
    }

    @Published var state: MainViewState

    private var router: Router?
    private var modelContext: ModelContext?

    func handle(_ event: MainViewEvent) {
        switch event {
        case let .setup(router, resumeModelQuery, modelContext):
            setup(router: router, resumeModelQuery: resumeModelQuery, modelContext: modelContext)
        case .onEditResume:
            toResumeEditor()
        case .onDeleteResume:
            deleteResume()
        case let .clipLink(contactId):
            clipLink(by: contactId)
        }
    }

    private func setup(
        router: Router?,
        resumeModelQuery: [ResumeModel],
        modelContext: ModelContext?
    ) {
        self.router = router

        if let resumeModel = resumeModelQuery.first {
            state.resume = .init(from: resumeModel)
        }

        self.modelContext = modelContext
    }

    private func deleteResume() {
        do {
            try modelContext?.delete(model: ResumeModel.self)
            state.resume = .init()
        } catch {}
    }

    private func clipLink(by contactId: UUID) {
        if let link = state.resume.contacts.first(where: { $0.id == contactId })?.link {
            UIPasteboard.general.setValue(link, forPasteboardType: "public.plain-text")
        }
    }

    // MARK: Routing

    private func toResumeEditor() {
        router?.path.append(Route.resumeEditor)
    }
}
