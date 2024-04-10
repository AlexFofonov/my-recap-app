//
//  Assembly.swift
//
//  AlexFofonov in 2024
//

import SwiftUI

final class Assembly {
    // MARK: Views

    func mainView() -> MainView<some MainViewModel> {
        MainView(viewModel: mainViewModel)
    }

    func resumeEditor() -> ResumeEditorView<some ResumeEditorViewModel> {
        ResumeEditorView(viewModel: resumeEditorViewModel)
    }

    // MARK: ViewModels

    private lazy var mainViewModel: some MainViewModel = MainViewModelImp()

    private lazy var resumeEditorViewModel: some ResumeEditorViewModel = ResumeEditorViewModelImp()
}
