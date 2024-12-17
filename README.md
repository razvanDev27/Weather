# Weather

Description:
A simple weather tracking app built with Swift and SwiftUI that allows users to search for a city, view its current weather, and persist the selected city across app launches. This app demonstrates clean architecture with MVVM, API integration with Alamofire, and local storage using UserDefaults.

The Weather API key is hardcoded on the request in this case, but usually I would get it from the backend via a request.

Tech Stack
- SwiftUI & Combine
- Architecture: MVVM
- Networking: Alamofire
- Local Storage: UserDefaults -> for city persistence
