//
//  MainView.swift
//
//  AlexFofonov in 2024
//

import SwiftData
import SwiftUI

struct MainView<ViewModel: MainViewModel>: View {
    @ObservedObject var viewModel: ViewModel

    @Environment(\.router) private var router
    @Environment(\.modelContext) private var modelContext
    @Query private var resumeModelQuery: [ResumeModel]

    @State private var showingEditingDialog: Bool = false
    @State private var showingResumeDeletionAlert: Bool = false
    @State private var clippedLinkIds: [UUID] = []

    var body: some View {
        Form {
            Section(L10n.Base.Resume.title) {
                List {
                    if let uiImage = viewModel.state.resume.uiImage {
                        HStack {
                            Spacer()

                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .frame(maxWidth: 200, maxHeight: 200)
                                .animation(nil, value: clippedLinkIds)

                            Spacer()
                        }
                    }

                    if viewModel.state.resume.isEmpty {
                        TitleButton(L10n.Main.ResumeSection.empty) {
                            viewModel.handle(.onEditResume)
                        }
                    }

                    if !viewModel.state.resume.name.isEmpty {
                        LabeledContent(L10n.Base.Resume.name, value: viewModel.state.resume.name)
                    }

                    if !viewModel.state.resume.age.isEmpty {
                        LabeledContent(L10n.Base.Resume.age, value: viewModel.state.resume.age)
                    }

                    if !viewModel.state.resume.job.isEmpty {
                        LabeledContent(L10n.Base.Resume.job, value: viewModel.state.resume.job)
                    }

                    if !viewModel.state.resume.contacts.isEmpty {
                        DisclosureGroup {
                            ForEach(viewModel.state.resume.contacts, id: \.id) { contact in
                                HStack {
                                    LabeledContent(contact.title, value: contact.link)

                                    IconButton(
                                        clippedLinkIds.contains(where: { $0 == contact.id }) ?
                                            .check :
                                            .clipboard
                                    ) {
                                        withAnimation(.easeOut(duration: 0.4)) {
                                            clippedLinkIds.append(contact.id)
                                        } completion: {
                                            withAnimation(.easeInOut(duration: 0.4)) {
                                                clippedLinkIds.removeAll(where: { $0 == contact.id })
                                            }
                                        }

                                        viewModel.handle(.clipLink(contactId: contact.id))
                                    }
                                }
                            }
                        } label: {
                            Text(L10n.Base.Resume.contacts)
                                .bold()
                        }
                    }

                    if !viewModel.state.resume.fields.isEmpty {
                        DisclosureGroup {
                            ForEach(viewModel.state.resume.fields, id: \.id) { field in
                                HStack(alignment: .top) {
                                    Text(field.title)
                                        .frame(width: 100, alignment: .leading)
                                        .padding(.trailing, 10)

                                    Spacer()

                                    Text(field.description)
                                        .foregroundStyle(.gray)
                                        .font(.caption)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        } label: {
                            Text(L10n.Base.Resume.fields)
                                .bold()
                        }
                    }
                }
            }
        }
        .navigationTitle(L10n.Main.Toolbar.title)
        .toolbar {
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button(L10n.Base.edit) {
                    showingEditingDialog.toggle()
                }
                .confirmationDialog(
                    "",
                    isPresented: $showingEditingDialog,
                    titleVisibility: .hidden,
                    actions: {
                        Button(L10n.Main.ConfirmationDialog.editResume) {
                            viewModel.handle(.onEditResume)
                        }

                        Button(L10n.Main.ConfirmationDialog.deleteResume, role: .destructive) {
                            showingResumeDeletionAlert.toggle()
                        }

                        Button(L10n.Base.cancel, role: .cancel) {}
                    }
                )
                .opacity(viewModel.state.resume.isEmpty ? 0 : 1)
            }
        }
        .alert(L10n.Main.DeleteResumeAlert.title, isPresented: $showingResumeDeletionAlert, actions: {
            Button(L10n.Base.cancel, role: .cancel) {}

            Button(L10n.Base.delete, role: .destructive) {
                viewModel.handle(.onDeleteResume)
            }
        }, message: {
            Text(L10n.Main.DeleteResumeAlert.description)
        })
        .onAppear {
            viewModel.handle(.setup(
                router: router,
                resumeModelQuery: resumeModelQuery,
                modelContext: modelContext
            ))
        }
    }
}
