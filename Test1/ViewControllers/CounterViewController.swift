//
//  CounterViewController.swift
//  Test1
//
//  Created by Primeholding Template
//  Copyright © 2018 Primeholding. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CounterViewController: UIViewController {

    var viewModel: CounterViewModelType!
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel
            .bind(toViewController: self)
            .disposed(by: disposeBag)

        // Do view setup here.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }

     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
}

// MARK: - View Model Bindings
fileprivate extension CounterViewModelOutput {
    func bind(toViewController viewController: CounterViewController) -> [Disposable] {
        return [
            count.drive(viewController.countLabel.rx.text)
        ]
    }
}

fileprivate extension CounterViewModelInput {
    func bind(toViewController viewController: CounterViewController) -> [Disposable] {
        return [
            viewController.incrementButton.rx.tap.bind { [weak self] in self?.increment() },
            viewController.decrementButton.rx.tap.bind { [weak self] in self?.decrement() }
        ]
    }
}

fileprivate extension CounterViewModelType {
    func bind(toViewController viewController: CounterViewController) -> [Disposable] {
        return [
            input.bind(toViewController: viewController),
            output.bind(toViewController: viewController)
        ].flatMap { $0 }
    }
}
