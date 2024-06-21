// Copyright © 2024 Jose A Lobato. Under MIT license(https://mit-license.org)

import Foundation

extension CollectionFlowCoordinator {
    
    /// The list of Features that are under control of the
    /// CollectionFlowCoordinator.
    ///
    /// The features is the communication mechanism between the View and the
    /// associated Coordinator. So we should provide the essential information
    /// needed to build that features. Therefore the parameters.
    enum Feature: Identifiable, Hashable {
        
        case lectureDetails(String)

        var id: String {
            switch self {
            case .lectureDetails: return "lectureDetails"
            }
        }
    }
}
