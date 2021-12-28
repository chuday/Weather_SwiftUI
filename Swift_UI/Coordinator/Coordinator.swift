//
//  Coordinator.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 24.12.2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get }
    var childCoordinators: [Coordinator] { get }
    var onCompleted: (() -> Void)? { get set }
    
    func start()
}
