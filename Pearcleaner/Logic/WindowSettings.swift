//
//  WindowSettings.swift
//  Pearcleaner
//
//  Created by Alin Lupascu on 12/26/23.
//

import SwiftUI
import AlinFoundation
import Combine


class WindowSettings {
    private let windowWidthKey = "windowWidthKey"
    private let windowHeightKey = "windowHeightKey"
    private let windowXKey = "windowXKey"
    private let windowYKey = "windowYKey"
    var windows: [NSWindow] = []

    // Register default sizes if the AppStorage keys are invalid
    func registerDefaultWindowSettings(completion: @escaping () -> Void = {}) {
        let defaults = UserDefaults.standard
        // Get primary screen
        let screenFrame = NSScreen.main?.visibleFrame ?? NSRect(x: 0, y: 0, width: 800, height: 600)
        // Calculate default window sizes and x/y coordinates
        let defaultWidth = Float(900)  // Default width for regular window
        let defaultHeight = Float(628) // Default height for regular window
        let defaultX = Float((screenFrame.width - CGFloat(defaultWidth)) / 2 + screenFrame.origin.x) // Default X coordinate
        let defaultY = Float((screenFrame.height - CGFloat(defaultHeight)) / 2 + screenFrame.origin.y) // Default Y coordinate
        // Set defaults only if they are not already set
        if defaults.object(forKey: windowWidthKey) == nil {
            defaults.set(defaultWidth, forKey: windowWidthKey)
        }
        if defaults.object(forKey: windowHeightKey) == nil {
            defaults.set(defaultHeight, forKey: windowHeightKey)
        }
        if defaults.object(forKey: windowXKey) == nil {
            defaults.set(defaultX, forKey: windowXKey)
        }
        if defaults.object(forKey: windowYKey) == nil {
            defaults.set(defaultY, forKey: windowYKey)
        }
        completion()
    }

    // Save user window settings
    func saveWindowSettings(frame: NSRect) {
        UserDefaults.standard.set(Float(frame.size.width), forKey: windowWidthKey)
        UserDefaults.standard.set(Float(frame.size.height), forKey: windowHeightKey)
        UserDefaults.standard.set(Float(frame.origin.x), forKey: windowXKey)
        UserDefaults.standard.set(Float(frame.origin.y), forKey: windowYKey)
    }

    // Load default window settings or user defined settings
    func loadWindowSettings() -> NSRect {
        let width = CGFloat(UserDefaults.standard.float(forKey: windowWidthKey))
        let height = CGFloat(UserDefaults.standard.float(forKey: windowHeightKey))
        let x = CGFloat(UserDefaults.standard.float(forKey: windowXKey))
        let y = CGFloat(UserDefaults.standard.float(forKey: windowYKey))
        return NSRect(x: x, y: y, width: width, height: height)
    }

    // Reset to default sizes when toggling the window state
    func resetWindowSettings(mini: Bool) -> NSRect {
        let screenFrame = NSScreen.main?.visibleFrame ?? NSRect(x: 0, y: 0, width: 800, height: 600)
        // Define sizes based on whether mini mode is active
        let defaultWidth: CGFloat = mini ? 300 : 900  // Mini or Regular width
        let defaultHeight: CGFloat = mini ? 373 : 628 // Mini or Regular height
        // Calculate the X and Y coordinates based on the size
        let defaultX = (screenFrame.width - defaultWidth) / 2 + screenFrame.origin.x
        let defaultY = (screenFrame.height - defaultHeight) / 2 + screenFrame.origin.y
        // Store these values in UserDefaults (if needed)
        UserDefaults.standard.set(Float(defaultWidth), forKey: windowWidthKey)
        UserDefaults.standard.set(Float(defaultHeight), forKey: windowHeightKey)
        UserDefaults.standard.set(Float(defaultX), forKey: windowXKey)
        UserDefaults.standard.set(Float(defaultY), forKey: windowYKey)
        // Return the frame for the window with appropriate size and position
        return NSRect(x: defaultX, y: defaultY, width: defaultWidth, height: defaultHeight)
    }

    // Launch new app windows on demand
    func newWindow<V: View>(mini: Bool, withView view: @escaping () -> V) {
        // Close existing window
        findAndHideWindows(named: ["Pearcleaner"])
        // Create new window using defaults
        let contentView = view
        let frame = self.resetWindowSettings(mini: mini)
        let newWindow = NSWindow(
            contentRect: frame,
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
        newWindow.contentView = NSHostingView(rootView: contentView())
        newWindow.titlebarAppearsTransparent = true
        newWindow.isMovableByWindowBackground = true
        newWindow.title = "Pearcleaner"
        newWindow.isRestorable = false
        self.windows.append(newWindow)
        newWindow.titleVisibility = .hidden
        newWindow.makeKeyAndOrderFront(nil)
    }

}
