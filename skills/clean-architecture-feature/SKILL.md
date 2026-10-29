---
name: clean-architecture-feature
description: Use this skill when building, refactoring, or generating code for a new or existing feature in a Flutter project. It enforces a strict Feature-Based Clean Architecture structure and specific guidelines regarding UseCases, Data Sources, and State Management.
---

# Clean Architecture - Feature Based (Flutter)

This skill dictates the file and folder structure for a feature in a Flutter project following Clean Architecture.

## Folder Structure

Whenever you create a new feature (e.g., `auth`), place it under its respective feature directory (like `lib/apps/features/common/<feature_name>`) and structure it EXACTLY as follows:

```
<feature_name>/
├── data/
│   ├── dto/
│   │   └── <entity>_dto/
│   │       └── ..._dto.dart
│   ├── mappers/
│   │   └── ..._mapper.dart
│   ├── service/
│   │   └── ..._service.dart (e.g., external SDK wrappers)
│   ├── repository/
│   │   └── <feature>_repository_impl.dart
│   └── data_source/
│       ├── remote/
│       │   └── <entity>/
│       │       ├── impl/
│       │       │   └── ..._remote_data_source_impl.dart
│       │       └── ..._remote_data_source.dart
│       └── local/ (if applicable)
├── domain/
│   ├── entity/
│   │   └── <entity>/
│   │       └── ..._entity.dart
│   ├── use_case/
│   │   └── ..._use_case.dart
│   └── repository/
│       └── <feature>_repository.dart
└── presentation/
    ├── screens/
    │   └── ..._screen.dart
    ├── widgets/
    │   └── ..._widget.dart
    └── controller/
        ├── ..._bloc.dart (or cubit)
        ├── ..._event.dart (if using bloc)
        └── ..._state.dart
```

## Architectural Rules

### 1. The Use Case Rule (CRITICAL)
- **NO BRIDGE USE CASES:** State management (Bloc/Cubit) does **NOT** always need to communicate with the Repository through a UseCase.
- **Pass-through logic:** If a UseCase would just call the repository method and return its result without doing anything else (i.e., acting just as a "bridge"), **DO NOT CREATE IT**. The Bloc/Cubit should depend directly on the Repository instead.
- **When to create a UseCase:** ONLY create a UseCase if it actually contains logic (such as combining multiple repository calls, data transformation, or specific business rules).

### 2. Layer Dependencies
- **Presentation Layer** (screens, widgets, controllers) can depend on **Domain** layer (Entities, Repositories, or UseCases).
- **Data Layer** (DTOs, Data Sources, Repository Impls, Mappers) depends on **Domain** layer (to implement the interfaces and map to entities).
- **Domain Layer** (Entities, Repository Interfaces, UseCases) must **NOT** depend on Data or Presentation layers. It is the core of the feature.

### 3. Data Mapping
- Mappers are placed in `data/mappers/` to convert Data Transfer Objects (DTOs) from the `data/dto/` folder to Domain Entities, and vice versa.

### 4. Data Sources
- Define interfaces for data sources (e.g., `user_remote_data_source.dart`) and place implementations in an `impl` folder (e.g., `impl/user_remote_data_source_impl.dart`).

## Examples

### 1. Directly using Repository (No UseCase)
When there is no business logic to apply, skip the UseCase and inject the Repository directly into the Bloc/Cubit.

```dart
// presentation/controller/auth_bloc.dart
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  
  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<LogoutEvent>((event, emit) async {
      // Calling repo directly because there is no business rule to enforce here.
      await _authRepository.logout();
      emit(Unauthenticated());
    });
  }
}
```

### 2. Creating a UseCase (With Business Logic)
When the action involves multiple steps, validation, or business rules, create a UseCase.

```dart
// domain/use_case/login_use_case.dart
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<User> call(String email, String password) async {
    // Contains business logic/rules: e.g. validation before calling repo
    if (!email.contains('@')) {
      throw ValidationException('Invalid email format');
    }
    
    final user = await _repository.login(email, password);
    
    if (!user.isActive) {
      throw BusinessException('User account is deactivated');
    }
    
    return user;
  }
}
```
