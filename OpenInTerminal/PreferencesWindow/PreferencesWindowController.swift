//
//  PreferencesWindowController.swift
//  OpenInTerminal
//
//  Created by Jianing Wang on 2019/4/29.
//  Copyright © 2019 Jianing Wang. All rights reserved.
//

import Cocoa

class PreferencesWindowController: NSWindowController {

    override var contentViewController: NSViewController? {
        didSet {
            removeHiddenTabs()
        }
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        removeHiddenTabs()
    }

    override func showWindow(_ sender: Any?) {
        removeHiddenTabs()
        super.showWindow(sender)
    }

    private func removeHiddenTabs() {
        guard let tabViewController = contentViewController as? NSTabViewController else { return }
        let hiddenItems = tabViewController.tabViewItems.filter {
            !($0.viewController is GeneralPreferencesViewController)
        }
        for item in hiddenItems {
            tabViewController.removeTabViewItem(item)
        }
        if !tabViewController.tabViewItems.isEmpty {
            tabViewController.selectedTabViewItemIndex = 0
        }
        if tabViewController.tabViewItems.count <= 1 {
            tabViewController.tabStyle = .unspecified
            window?.toolbar = nil
            if let general = tabViewController.tabViewItems.first?.viewController {
                _ = general.view
                let size = general.preferredContentSize
                if size.width > 0 && size.height > 0 {
                    window?.setContentSize(size)
                }
            }
        }
    }
    
}
