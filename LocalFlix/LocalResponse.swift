//
//  LocalResponse.swift
//  FlixLocal
//
//  Created by Matt on 04/04/2022.
//

import Foundation

/// Mocked local response, used in the local service. This returns 3 example movies to be used in UITests and Snapshot Tests, to allow tests to run without needing a call of to the service
class LocalResponse {
    static let movies: [MovieDetails] = [
        MovieDetails(id: 508947,
                     title: "Turning Red",
                     overview: "Thirteen-year-old Mei is experiencing the awkwardness of being a teenager with a twist – when she gets too excited, she transforms into a giant red panda.",
                     backdropPath: "fOy2Jurz9k6RnJnMUMRDAgBwru2",
                     releaseDate: "2022-03-01",
                     rating: 7.5,
                     posterPath: "qsdjk9oAKSQMWs0Vt5Pyfh6O4GZ"),
        
        MovieDetails(id: 634649,
                     title: "Spider-Man: No Way Home",
                     overview: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.",
                     backdropPath: "iQFcwSGbZXMkeyKrxbPnwnRo5fl",
                     releaseDate: "2021-12-15",
                     rating: 8.2,
                     posterPath: "1g0dhYtq4irTY1GPXvft6k4YLjm"),
        
        MovieDetails(id: 335787,
                     title: "Uncharted",
                     overview: "A young street-smart, Nathan Drake and his wisecracking partner Victor “Sully” Sullivan embark on a dangerous pursuit of “the greatest treasure never found” while also tracking clues that may lead to Nathan’s long-lost brother",
                     backdropPath: "cTTggc927lEPCMsWUsdugSj6wAY",
                     releaseDate: "2022-02-10",
                     rating: 7.2,
                     posterPath: "sqLowacltbZLoCa4KYye64RvvdQ")
    ]
}
