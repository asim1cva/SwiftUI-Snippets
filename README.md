## SwiftUI-Snippets – Liquid Glass Auth Flow

Modern SwiftUI playground showcasing reusable components, clean architecture, and an iOS 16+/26-style liquid glass (glassmorphism) authentication experience.

### Features
- **Liquid glass UI**: Angular gradients, blur, layered shadows, and frosted cards.
- **Auth flow**: Login + Register with validation, loading states, and error/success banners.
- **Clean Architecture**: Separated into `Data`, `Domain`, and `Presentation` layers.
- **Reusable components**: `AppButtonView` and `AppTextFieldView` for consistent styling.

### Screenshots
Add your own screenshots to a `Screenshots` folder in the repo and update the paths below.

- **Login – Liquid Glass**

```markdown
![Login Screen](Screenshots/login-glass.png)
```

- **Register – Liquid Glass**

```markdown
![Register Screen](Screenshots/register-glass.png)
```

### Project Structure
- **SwiftUI-Snippets/**
  - `SwiftUI_SnippetsApp.swift`: App entry point using `AuthRootView`.
  - `Components/`: Shared UI components (`AppButtonView`, `AppTextFieldView`).
  - `Clean-Architecture/`
    - `Domain/`: `Entities`, `Repositories`, `UseCases` (`LoginUseCase`, `RegisterUseCase`).
    - `Data/`: `ApiClient`, concrete `AuthRepositoryImpl`.
    - `Presentation/`: `ViewModels` + `Views` (`LoginView`, `RegisterView`, `AuthRootView`).

### Navigation & Routing
- Uses **`NavigationStack` + `NavigationPath`** with an `AuthRoute` enum.
- `AuthRootView` hosts the stack and switches between Login and Register.

### Requirements
- **Xcode**: 15+ (recommended)
- **iOS**: 17+ target (adjust as needed)

### Running the App
1. Open `SwiftUI-Snippets.xcodeproj` in Xcode.
2. Select an iOS simulator (e.g., iPhone 15).
3. Run the **SwiftUI-Snippets** scheme.

### Customizing the Look
- Adjust the liquid background gradients in:
  - `LoginView`
  - `RegisterView`
- Tweak button and field styling in:
  - `Components/AppButtonView.swift`
  - `Components/AppTextFieldView.swift`

