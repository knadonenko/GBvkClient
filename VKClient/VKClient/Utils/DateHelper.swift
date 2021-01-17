//
// Created by Константин Надоненко on 17.01.2021.
//

import Foundation

struct DateHelper {

    let currentDate: String

    init() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        currentDate = formatter.string(from: Date())
    }

}