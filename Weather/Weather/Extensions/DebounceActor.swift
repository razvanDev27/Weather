//
//  DebounceActor.swift
//  Weather
//
//  Created by Razvan Copaciu on 17.12.2024.
//

import SwiftUI

actor DebounceActor {
    private var latestTask: Task<Void, Never>?

    func debounce(for seconds: TimeInterval, action: @escaping () -> Void) async {
        latestTask?.cancel()

        latestTask = Task {
            try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
            if !Task.isCancelled {
                action()
            }
        }
    }
}
