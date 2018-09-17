//
//  DetailsViewController.swift
//  Test1
//
//  Created by Primeholding Template. on 13.09.18.
//  Copyright © 2018 Primeholding. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailsViewController: UIViewController {

    var viewModel: DetailsViewModelType!
    private let disposeBag = DisposeBag()
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    @IBOutlet weak var reloadButton: UIBarButtonItem!
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

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

// MARK: - View Model Bindings
fileprivate extension DetailsViewModelOutput {
    func bind(toViewController viewController: DetailsViewController) -> [Disposable] {
        return [
            details
                .drive(viewController.detailsLabel.rx.text),
            isLoading
                .drive(viewController.activityIndicator.rx.isAnimating),
            isLoading
                .drive(viewController.detailsLabel.rx.isHidden),
            isLoading
                .map { !$0 }
                .drive(viewController.reloadButton.rx.isEnabled)
        ]
    }
}

fileprivate extension DetailsViewModelInput {
    func bind(toViewController viewController: DetailsViewController) -> [Disposable] {
        return [
            viewController.reloadButton.rx.tap
                .startWith(())
                .bind { [weak self] in self?.fetch() }
        ]
    }
}

fileprivate extension DetailsViewModelType {
    func bind(toViewController viewController: DetailsViewController) -> [Disposable] {
        return [
            input.bind(toViewController: viewController),
            output.bind(toViewController: viewController)
        ].flatMap { $0 }
    }
}
