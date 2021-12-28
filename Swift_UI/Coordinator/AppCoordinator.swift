//
//  AppCoordinator.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 24.12.2021.
//

import UIKit
import Combine
import SwiftUI

class AppCoordinator: Coordinator {
    
    
    private(set) var childCoordinators: [Coordinator] = []
    private let coreDataService: CoreDataService = CoreDataService(modelName: "City")
    private var cancellables: Set<AnyCancellable> = []
    
    let navigationController: UINavigationController
    var onCompleted: (() -> Void)?
    
    public init(navigationController: UINavigationController, onCompleted: (() -> Void)? = nil) {
        self.navigationController = navigationController
        self.onCompleted = onCompleted
    }
    
    let loginViewModel: LoginViewModel = LoginViewModel()
    
    func start() {
        let loginViewBinding = Binding<Bool>.init { [weak self] in
            guard let self = self else { return false }
            return self.loginViewModel.isUserLoggedIn
        } set: { [weak self] newValue in
            guard let self = self else { return }
            self.loginViewModel.isUserLoggedIn = newValue
        }
        
        let loginView = VKLoginWebView(isAuthorized: loginViewBinding)
        let loginViewController = UIHostingController(rootView: loginView)
        navigationController.pushViewController(loginViewController, animated: false)
        
        loginViewModel
            .$isUserLoggedIn
            .removeDuplicates()
            .subscribe(on: RunLoop.main)
            .sink { [weak self] isUserLoggedIn in
                guard let self = self else { return }
                
                if isUserLoggedIn {
                    let citiesController = self.createCitiesController()
                    self.navigationController.pushViewController(citiesController, animated: true)
                } else {
                    self.navigationController.popToViewController(loginViewController, animated: true)
                }
            }
            .store(in: &cancellables)
    }
    
    private func createCitiesController() -> UIViewController {
        let context = coreDataService.context
        let citiesView = CitiesView().environment(\.managedObjectContext, context)
        return UIHostingController(rootView: citiesView)
    }
}
