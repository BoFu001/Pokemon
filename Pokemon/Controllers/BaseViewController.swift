//
//  BaseViewController.swift
//  Pokemon
//
//  Created by BoFu on 01/04/2020.
//  Copyright © 2020 BoFu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var spinner = UIActivityIndicatorView(style: .large)
    var noConnectionView = NoConnectionView.noConnectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSpinner()
        noConnectionViewSetup()
    }
    
    private func addSpinner(){
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = UIColor.systemBlue
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinner.isHidden = false
    }
    
    private func noConnectionViewSetup(){
        
        noConnectionView?.retryAction = {
            self.retry()
        }
        
        noConnectionView?.alpha = 0
        
        if let nCV = noConnectionView {
            view.addSubview(nCV)
            nCV.pinToSuperView()
        }
    }
    
    func retry() { }
    
}
