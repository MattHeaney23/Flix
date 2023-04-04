//
//  FlixSnapshotTests.swift
//  FlixSnapshotTests
//
//  Created by Matt on 04/04/2022.
//

@testable import FlixLocal
import RxSwift
import SnapshotTesting
import XCTest

class DetailsViewSnapshotTests: XCTestCase {
    
    //MARK: - Record Settings
    var recordMode = false
    
    //MARK: - Tests
    
    func test_snapshot_detailsViewController_Image_SpidermanExample() {
        let viewModel = DetailsViewModel(movieDetails: LocalResponse.movies[1])
        let view = DetailsViewController(viewModel: viewModel)
        
        assertSnapshot(matching: view,
                       as: .image(on: .iPhoneX,
                                  traits: .init(horizontalSizeClass: .compact)),
                       named: "MainView_SnapshotTest_Image_iPhoneX",
                       record: self.recordMode,
                       timeout: 5)
    }
    
    func test_snapshot_detailsViewController_Image_UnchartedExample() {
        let viewModel = DetailsViewModel(movieDetails: LocalResponse.movies[2])
        let view = DetailsViewController(viewModel: viewModel)
        
        assertSnapshot(matching: view,
                       as: .image(on: .iPhoneX,
                                  traits: .init(horizontalSizeClass: .compact)),
                       named: "MainView_SnapshotTest_Image_iPhoneX",
                       record: self.recordMode,
                       timeout: 5)
    }
    
}
