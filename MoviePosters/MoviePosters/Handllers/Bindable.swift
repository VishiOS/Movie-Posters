//
//  Bindable.swift
//  MoviePosters
//
//  Created by Vishal22 Sharma on 13/03/21.
//

import Foundation

class Bindable<T> {
    typealias Listener = ((T) -> Void)
    private var listener: Listener?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ v: T) {
        self.value = v
    }

    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
