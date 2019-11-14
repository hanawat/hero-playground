//
//  ViewController.swift
//  HeroPlayground
//
//  Created by Hanawa Takuro on 2019/11/14.
//  Copyright © 2019 Hanawa Takuro. All rights reserved.
//

import UIKit
import Hero

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func present(_ sender: Any) {
        guard let a = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "ViewControllerA") as? ViewControllerA else { fatalError("Not implemented") }
        a.hero.isEnabled = true
        present(a, animated: true)
    }
}

class ViewControllerA: UIViewController, ViewControllerBDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.hero.modifiers = [.translate(x: -view.bounds.width)]
    }

    @IBAction func present(_ sender: Any) {
        guard let b = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "ViewControllerB") as? ViewControllerB else { fatalError("Not implemented") }
        view.hero.modifiers = [] // Remove hero modifiers.
        b.hero.isEnabled = true
        b.delegate = self
        present(b, animated: true)
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true)
    }

    func viewConrtollerBDidDismiss(_ b: ViewControllerB) {
        view.hero.modifiers = [.translate(x: -view.bounds.width)] // Setup hero modifiers.
    }
}

protocol ViewControllerBDelegate: class {

    func viewConrtollerBDidDismiss(_ b: ViewControllerB)
}

class ViewControllerB: UIViewController { // Over full screen

    @IBOutlet weak var square: UIView! {
        didSet { square.hero.modifiers = [.fade, .translate(y: 100.0)] }
    }

    weak var delegate: ViewControllerBDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func dismiss(_ sender: Any) {
        dismiss(animated: true, completion: { [unowned self] in
            self.delegate?.viewConrtollerBDidDismiss(self)
        })
    }
}

