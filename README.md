# Akakce Case Study iOS

A sample iOS e-commerce application built using Swift that demonstrates modern iOS development practices, clean architecture, and responsive UI design.

## Features

- Display products in both horizontal and grid layouts
- Product details view with comprehensive information
- Star rating system for products
- Pull-to-refresh functionality
- Responsive design supporting different orientations
- Image caching using Kingfisher
- Network layer with error handling

## Architecture

The project follows the MVVM (Model-View-ViewModel) architecture pattern:

- **Models**: Data models representing the product information
- **Views**: UI components and custom views
- **ViewModels**: Business logic and data management
- **Services**: Network layer and API communication

## Network Layer

The app uses a custom networking layer that includes:

- Error handling
- URL request construction
- Response parsing
- API route management

The base URL for the API is:


## Requirements

- iOS 18.0+
- Xcode 16.0+
- Swift 5.0+


## Dependencies

- **Kingfisher**: For efficient image loading and caching