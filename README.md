# 🌐 Dairy B2B System

Welcome to the **official monorepo** for **Dairy B2B System Apps & Services** 🚀  
This repository contains our **apps, shared packages, and static website** – all managed in a single codebase with **Melos**.

---

## 📱 Applications
### 1. Orders App (`apps/dairyB2b_orders`)
For clients (shops, hotels, distributors):
- Place daily milk orders  
- Manage and track deliveries  
- View billing summaries  

### 2. Management App (`apps/dairyB2b_management`)
For admins/managers only:
- Manage clients and orders  
- Track revenue and deliveries  
- Handle company-level actions  

---

## 📦 Packages
Reusable internal Flutter/Dart packages:
- `system_assets` → icons, images, and brand assets  
- `models` → shared model definitions  
- `common` → generic utilities  
- `core` → core logic, helpers, and constants  
- `repo` → common Firestore data access & Riverpod providers  
- `auth` → authentication flows & logic  

---

## 🛠️ Development

We use modern tooling for scalability:

- [Flutter](https://flutter.dev/)  
- [FVM](https://fvm.app/) → manage Flutter SDK version  
- [Melos](https://melos.invertase.dev/) → manage monorepo  
- [Riverpod](https://riverpod.dev/) → state management  
- [go_router](https://pub.dev/packages/go_router) → navigation  
- [build_runner](https://pub.dev/packages/build_runner) → code generation  

### ▶️ Setup
```bash
# Install Melos globally
dart pub global activate melos
```
```bash
# Bootstrap the workspace
melos bootstrap
```
```bash
# Run build_runner across all packages
melos run build
```
```bash
# Run tests in all packages
melos run test
```

```bash
# Clean and re-bootstrap
melos clean ; melos bootstrap
```
### 🏗️ Building APKs

To generate release APKs for Android, run:

```bash
# Build APKs for all ABIs separately
flutter build apk --split-per-abi
```