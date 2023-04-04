**App Name:** “flix.”

![Flix-HomeView](https://user-images.githubusercontent.com/129856192/229848184-d6b9680b-aed8-48c4-bc66-45241a090200.png) ![Flix-MovieDetailView](https://user-images.githubusercontent.com/129856192/229848563-6daa332c-3757-4ee7-9f0e-d5c7a034363d.png) ![Flix-Search](https://user-images.githubusercontent.com/129856192/229848594-e31b381d-ed3f-45cc-8ebc-ceb61bbac7c9.png)

**Frameworks Used:**

- UIKit. All views were created in code, rather than in storyboards or xib files.
- RxSwift/ RxAlamofire

**Architecture:**

- MVVM-C has been used (MVVM and the coordinator pattern)
- View models were created for all view controllers and cells.
- A coordinator has been created to handle navigation, ensure navigation is flexible, scalable and maintainable using the Coordinator Pattern
- Services has been built for core functionality in the app. This includes:
    - NetworkService, which handles making requests via RxAlamofire
    - RepoService, which handles storing and loading data regarding the user’s favourites movies from UserDefaults
    - ImageCacheService, which handles storing and loading images from the cache
- A dependency injection system was used. Services are injected into objects via the initialiser, and have a default value. This allows the main version of these services to be used, but also allowing to easily swap in a mock version of the service.

**Targets:**

Two targets have been set up in the app: a production target, and a local target. This has been completed to allow for efficient UITests and Snapshot tests.

Prod Target: “Flix”
- When running this target, the app will complete real requests to the API, populating the app’s data source from the response.

Local Target: “FlixLocal”
- When running this target, the app will use mocked data hard-coded into the target. This includes three example movies, and all image assets needed.

**Tests:**

Unit tests, UITests and Snapshot tests have been added to the project.

- Unit tests run in the prod target. Tests included are for the MainViewModel and the DetailsViewModel. These tests make use of mocked versions of the NetworkService and the RepoService to ensure no real API requests are made in the tests, keeping efficiency high.

- UITests run in the local target, making use of local data. The UITests use the Robot Pattern to ensure UITests stay very readable and scalable.

- SnapshotTests run in local, using the pod ‘SnapshotTesting’. The snapshot tests focus on the detail view controller with two different example movies. These tests need to be running on an iPhone 13 on iOS 15, and on an M1 backed machine to pass (Snapshot testing is a great tool, but requires the same simulator setup to pass)
