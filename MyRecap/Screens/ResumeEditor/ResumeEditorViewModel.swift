//
//  ResumeEditorViewModel.swift
//
//  AlexFofonov in 2024
//

import PhotosUI
import SwiftData
import SwiftUI

enum ResumeEditorViewEvent: BaseViewEvent {
    case setup(modelContext: ModelContext?, resumeModelQuery: [ResumeModel])

    case onFinishEditing

    case onUpdateSelectedPhotos

    case onAddContact
    case onRemoveContact(contactId: UUID)

    case onAddResumeField
    case onRemoveResumeField(fieldId: UUID)

    case onSaveResume
}

struct ResumeEditorViewState: BaseViewState {
    init(
        resume: Resume = .init(),
        selectedPhotos: [PhotosPickerItem] = [],
        isSaveActive: Bool = false
    ) {
        self.resume = resume
        self.selectedPhotos = selectedPhotos
        self.isSaveActive = isSaveActive
    }

    var resume: Resume
    var selectedPhotos: [PhotosPickerItem]
    var isSaveActive: Bool
}

protocol ResumeEditorViewModel: BaseViewModel where ViewState == ResumeEditorViewState, ViewEvent == ResumeEditorViewEvent {}

final class ResumeEditorViewModelImp: ResumeEditorViewModel {
    init(
        state: ResumeEditorViewState = .init(),
        modelContext: ModelContext? = nil,
        currentResumeModel: ResumeModel? = nil
    ) {
        self.state = state
        self.modelContext = modelContext
        self.currentResumeModel = currentResumeModel
    }

    @Published var state: ResumeEditorViewState

    private var modelContext: ModelContext?
    private var currentResumeModel: ResumeModel?
    private var isResumeChanged: Bool {
        Resume(from: currentResumeModel ?? .init()) != state.resume
    }

    func handle(_ event: ResumeEditorViewEvent) {
        switch event {
        case let .setup(modelContext, resumeModelQuery):
            setup(modelContext: modelContext, resumeModelQuery: resumeModelQuery)
        case .onFinishEditing:
            break
        case .onUpdateSelectedPhotos:
            updateImage()
        case .onAddContact:
            addContact()
        case let .onRemoveContact(contactId):
            removeContact(by: contactId)
        case .onAddResumeField:
            addResumeField()
        case let .onRemoveResumeField(fieldId):
            removeResumeField(by: fieldId)
        case .onSaveResume:
            saveResume()
        }

        checkResumeChanged()
    }

    private func setup(modelContext: ModelContext?, resumeModelQuery: [ResumeModel]) {
        self.modelContext = modelContext

        if !resumeModelQuery.isEmpty, let resumeModel = resumeModelQuery.first {
            currentResumeModel = resumeModel
            state.resume = .init(from: resumeModel)
        } else {
            state.resume = .init()
            let resumeModel = ResumeModel(from: state.resume)

            currentResumeModel = resumeModel
            modelContext?.insert(resumeModel)
        }

        DispatchQueue.main.async { [weak self] in
            self?.checkResumeChanged()
        }
    }

    private func saveResume() {
        guard let currentResumeModel else {
            return
        }

        let newResumeModel = ResumeModel(from: state.resume)

        modelContext?.delete(currentResumeModel)
        modelContext?.insert(newResumeModel)

        self.currentResumeModel = newResumeModel
        checkResumeChanged()
    }

    private func updateImage() {
        guard let photo = state.selectedPhotos.first else {
            return
        }

        photo.loadTransferable(type: Data.self, completionHandler: { [weak self] result in
            guard let self else {
                return
            }

            switch result {
            case let .success(imageData):
                state.resume.imageData = imageData
                checkResumeChanged()
            case .failure:
                state.resume.imageData = nil
            }
        })
    }

    private func addContact() {
        state.resume.contacts.append(.init())
        for (index, item) in state.resume.contacts.enumerated() {
            item.sortIndex = index
        }
    }

    private func removeContact(by id: UUID) {
        state.resume.contacts.removeAll(where: { $0.id == id })
    }

    private func addResumeField() {
        state.resume.fields.append(.init())
        for (index, item) in state.resume.fields.enumerated() {
            item.sortIndex = index
        }
    }

    private func removeResumeField(by id: UUID) {
        state.resume.fields.removeAll(where: { $0.id == id })
    }

    private func checkResumeChanged() {
        state.isSaveActive = isResumeChanged
    }
}
