//
//  PermView.swift
//  Pearcleaner
//
//  Created by Alin Lupascu on 11/16/23.
//


import SwiftUI

struct PermView: View {
    @EnvironmentObject var appState: AppState
    @AppStorage("settings.general.selectedTab") private var selectedTab: CurrentTabView = .general

    var body: some View {
        VStack {
            HStack {
                
                Spacer()
                
                Text("Pearcleaner Permissions")
                    .font(.title)
                    .bold()
                    .padding(.vertical)
                    .padding(.top, 5)

                Spacer()
                
            }

            Divider()
                .padding(.bottom)

            Spacer()

            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .top, spacing: 20) {
                    Image(systemName: "externaldrive")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color("mode").opacity(0.5))
                    Text("Full Disk Access permission to find and delete files in system paths")
                        .font(.callout)
                        .foregroundStyle(Color("mode").opacity(0.5))
                }

                HStack(alignment: .top, spacing: 20) {
                    Image(systemName: "accessibility")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color("mode").opacity(0.5))
                    Text("Accessibility permission to delete files via Finder")
                        .font(.callout)
                        .foregroundStyle(Color("mode").opacity(0.5))
                }

                HStack(alignment: .top, spacing: 20) {
                    Image(systemName: "gearshape.2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color("mode").opacity(0.5))
                    Text("Automation permission to perform extension actions via Finder")
                        .font(.callout)
                        .foregroundStyle(Color("mode").opacity(0.5))
                }

                HStack(alignment: .top, spacing: 20) {
                    Image(systemName: "calendar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color("mode").opacity(0.5))
                    Text("Reminders permission to find and delete some reminder files that certain apps cache")
                        .font(.callout)
                        .foregroundStyle(Color("mode").opacity(0.5))
                }

                HStack(alignment: .top, spacing: 20) {
                    Image(systemName: "info.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color("mode").opacity(0.5))
                    Text("Add Pearcleaner in both Privacy panes via the + or by dragging the app over the pane. If the app is already pre-populated in the list, just toggle On if neeeded. Restart app when both permissions are granted")
                        .font(.callout)
                        .foregroundStyle(Color("mode").opacity(0.5))
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            HStack {
                
                if #available(macOS 14.0, *) {
                    SettingsLink {}
                        .buttonStyle(SimpleButtonBrightStyle(icon: "gear", label: "Settings", help: "Check permissions in Settings", color: Color("mode")))
                } else {
                    Button("Settings") {
                        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: NSApp.delegate, from: nil)
                    }
                    .buttonStyle(SimpleButtonBrightStyle(icon: "gear", label: "Settings", help: "Check permissions in Settings", color: .red))
                }


//                Button(action: {
//                    relaunchApp(afterDelay: 1)
//                }) {
//                    Text("Restart")
//                }
//                .buttonStyle(SimpleButtonBrightStyle(icon: "arrow.uturn.left.circle", label: "Restart", help: "Restart", color: .red))
//                .padding()

                Button(action: {
                    NewWin.close()
                }) {
                    Text("Close")
                }
                .buttonStyle(SimpleButtonBrightStyle(icon: "checkmark.circle", label: "Ok", help: "Ok", color: .blue))
                .padding()

//                Button(action: {
//                    if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles") {
//                        NSWorkspace.shared.open(url)
//                    }
//                }) {
//                    Text("Full Disk Access")
//                }
//                .buttonStyle(SimpleButtonBrightStyle(icon: "externaldrive", label: "Full Disk", help: "Full Disk", color: .accentColor))
//                .padding()
//                
//                Button(action: {
//                    if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility") {
//                        NSWorkspace.shared.open(url)
//                    }
//                }) {
//                    Text("Accessibility")
//                }
//                .buttonStyle(SimpleButtonBrightStyle(icon: "accessibility", label: "Accessibility", help: "Accessibility", color: .accentColor))
//                .padding()
//
//                Button("") {
//                    if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Automation") {
//                        NSWorkspace.shared.open(url)
//                    }
//                }
//                .buttonStyle(SimpleButtonBrightStyle(icon: "gearshape.2", label: "Automation", help: "Automation", color: .accentColor))
//                .padding()
//
//                Button("") {
//                    if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Reminders") {
//                        NSWorkspace.shared.open(url)
//                    }
//                }
//                .buttonStyle(SimpleButtonBrightStyle(icon: "calendar", label: "Reminders", help: "Reminders", color: .accentColor))


            }
            .onAppear {
                selectedTab = .general
            }

            
        }
        .padding(EdgeInsets(top: -25, leading: 0, bottom: 25, trailing: 0))
        
        
        
    }
    
    
}


