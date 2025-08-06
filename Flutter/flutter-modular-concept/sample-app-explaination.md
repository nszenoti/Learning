

# Flutter Modular Dependency Injection Guide

## 1. Basic Structure

Here's a complete example demonstrating dependency injection with Flutter Modular.

### Repository Layer
```dart:lib/src/data/repositories/user_repository.dart
class UserRepository {
  Future<List<String>> getUsers() async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    return ['John', 'Jane', 'Bob'];
  }
}
```

### State Management (Cubit)
```dart:lib/src/domain/cubit/user_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<List<String>> {
  final UserRepository _repository;

  UserCubit(this._repository) : super([]);

  Future<void> loadUsers() async {
    final users = await _repository.getUsers();
    emit(users);
  }
}
```

### Module Setup
```dart:lib/src/config/routes/app.module.dart
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    // Singleton: Same instance throughout app
    i.addSingleton(UserRepository.new);
    
    // Regular binding: New instance each time
    i.add<UserCubit>((i) => UserCubit(i.get<UserRepository>()));

    // Alternative: Lazy Singleton
    // i.addLazySingleton(UserRepository.new);
  }

  @override
  void routes(r) {
    r.child(
      '/users',
      child: (context) => MultiBlocProvider(
        providers: [
          BlocProvider<UserCubit>(
            create: (context) => Modular.get<UserCubit>(),
          ),
        ],
        child: const UserListPage(),
      ),
    );
  }
}
```

### UI Layer
```dart:lib/src/presentation/pages/user_list_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: BlocBuilder<UserCubit, List<String>>(
        builder: (context, users) {
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return ListTile(title: Text(users[index]));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Method 1: Using context.read
          context.read<UserCubit>().loadUsers();
          
          // Method 2: Using Modular.get directly
          // Modular.get<UserCubit>().loadUsers();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
```

## 2. Different Ways to Register Dependencies

### Basic Registration
```dart
void binds(i) {
  // Regular binding (new instance each time)
  i.add(UserCubit.new);

  // Singleton (same instance throughout app)
  i.addSingleton(UserRepository.new);

  // Lazy Singleton (created only when first requested)
  i.addLazySingleton(ExpensiveService.new);
}
```

### Registration with Dependencies
```dart
void binds(i) {
  // Simple dependency injection
  i.add<UserCubit>((i) => UserCubit(i.get<UserRepository>()));

  // Multiple dependencies
  i.add<ComplexCubit>((i) => ComplexCubit(
    i.get<UserRepository>(),
    i.get<SettingsRepository>(),
    'some parameter',
  ));
}
```

## 3. Ways to Access Dependencies

### In Widgets
```dart
// Using context.read (recommended for triggering events)
context.read<UserCubit>().loadUsers();

// Using BlocBuilder (for UI updates)
BlocBuilder<UserCubit, List<String>>(
  builder: (context, state) {
    // Build UI based on state
  },
);
```

### Direct Access
```dart
// Using Modular.get directly
final repository = Modular.get<UserRepository>();
final cubit = Modular.get<UserCubit>();
```

### In Route Definitions
```dart
void routes(r) {
  r.child(
    '/users',
    child: (context) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => Modular.get<UserCubit>(),
        ),
      ],
      child: const UserListPage(),
    ),
  );
}
```

## 4. Best Practices

1. **Dependency Registration**:
   - Use `addSingleton` for services that should be shared across the app
   - Use `add` for components that need fresh instances
   - Use `addLazySingleton` for expensive services that aren't needed immediately

2. **Accessing Dependencies**:
   - Prefer constructor injection when possible
   - Use `context.read` in widgets instead of direct `Modular.get`
   - Use `Modular.get` mainly in route definitions and dependency setup

3. **Error Prevention**:
   - Always register dependencies before using them
   - Keep module bindings organized and documented
   - Use type-safe dependency injection

This structure provides:
- Clear separation of concerns
- Easy testing capabilities
- Automatic resource disposal
- Centralized dependency management
- Type-safe dependency injection

Remember to import necessary packages and set up Flutter Modular in your `main.dart` file.
