//
//  ContentView.swift
//  SEN1
//
//  Created by Billy Gao on 1/13/24.
//

import SwiftUI
import AuthenticationServices
import MapKit

struct ContentView: View {
    @State private var isUserLoggedIn = false
    // Sample user data for demonstration
    @State private var users = [
        User(email: "user1@example.com", password: "password1", childName: "Child1", age: 8, specialEducationNeed: "Special Need 1", priorActivities: ["Activity1", "Activity2"], priorReports: ["Report1", "Report2"]),
        User(email: "user2@example.com", password: "password2", childName: "Child2", age: 11, specialEducationNeed: "Special Need 2", priorActivities: ["Activity3", "Activity4"], priorReports: ["Report3", "Report4"])
    ]

    // State variables for login, registration, and profile sheet presentation
    @State private var isRegisterSheetPresented = false
    @State private var isProfileSheetPresented = false

    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                Image("sky_background")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .opacity(0.6) // Set opacity to 60%
                    .edgesIgnoringSafeArea(.all)

                // Content
                ScrollView {
                    VStack(spacing: 20) {
                        // NEST Logo
                        Image("nest_logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .padding(.bottom, 20)

                        // Log In/Profile Button
                        if isUserLoggedIn {
                            // Profile Button
                            NavigationLink(destination: ProfileView(user: $users[0], users: $users, isProfileSheetPresented: $isProfileSheetPresented, isUserLoggedIn: $isUserLoggedIn)) {
                                VStack {
                                    Image("login_button_background") // Use the same background image as the log in button
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 300, height: 150) // Use the same size as the log in button
                                        .cornerRadius(15)
                                        .overlay(
                                            Text("Profile") // Use the same text and font as the log in button
                                                .foregroundColor(.white)
                                                .font(.system(size: 24, weight: .bold))
                                                .padding(20)
                                                .overlay(
                                                    Text("Profile")
                                                        .foregroundColor(.green)
                                                        .font(.system(size: 24, weight: .bold))
                                                        .padding(20)
                                                        .blur(radius: 5)
                                                )
                                        )
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                            }
                        } else {
                            // Log In Button
                            NavigationLink(destination: LoginView(users: $users, isUserLoggedIn: $isUserLoggedIn, isRegisterSheetPresented: $isRegisterSheetPresented)) {
                                VStack {
                                    Image("login_button_background")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 300, height: 150) // Further elongate the button horizontally
                                        .cornerRadius(15)
                                        .overlay(
                                            Text("Log In")
                                                .foregroundColor(.white)
                                                .font(.system(size: 24, weight: .bold)) // Increase the font size and make it bold
                                                .padding(20) // Increase padding for better visibility
                                                .overlay(
                                                    Text("Log In")
                                                        .foregroundColor(.green)
                                                        .font(.system(size: 24, weight: .bold)) // Increase the font size and make it bold
                                                        .padding(20)
                                                        .blur(radius: 5)
                                                )
                                        )
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                            }
                        }

                        // Special Education Activities Section
                        SectionView(title: "Special Education Activities", content: {
                            NavigationLink(destination: ActivitiesListView()) {
                                VStack {
                                    Image("explore_button_background")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 300, height: 150) // Further elongate the button horizontally
                                        .cornerRadius(15)
                                        .overlay(
                                            Text("Explore Activities")
                                                .foregroundColor(.white)
                                                .font(.system(size: 24, weight: .bold)) // Increase the font size and make it bold
                                                .padding(20)
                                                .overlay(
                                                    Text("Explore Activities")
                                                        .foregroundColor(.green)
                                                        .font(.system(size: 24, weight: .bold)) // Increase the font size and make it bold
                                                        .padding(20)
                                                        .blur(radius: 5)
                                                )
                                        )
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                            }
                        })

                        // Blog Section
                        SectionView(title: "Blog", content: {
                            NavigationLink(destination: BlogView()) {
                                VStack {
                                    Image("blog_button_background")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 300, height: 150) // Further elongate the button horizontally
                                        .cornerRadius(15)
                                        .overlay(
                                            Text("Read the Blog")
                                                .foregroundColor(.white)
                                                .font(.system(size: 24, weight: .bold)) // Increase the font size and make it bold
                                                .padding(20)
                                                .overlay(
                                                    Text("Read the Blog")
                                                        .foregroundColor(.green)
                                                        .font(.system(size: 24, weight: .bold)) // Increase the font size and make it bold
                                                        .padding(20)
                                                        .blur(radius: 5)
                                                )
                                        )
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.horizontal)
                            }
                        })
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct User: Identifiable {
    var id: UUID = UUID()
    var email: String
    var password: String
    var childName: String
    var specialEducationNeed: String
    var priorActivities: [String]
    var priorReports: [String]
    var age: Int

    // Add other properties as needed

    init(email: String, password: String, childName: String, age: Int, specialEducationNeed: String, priorActivities: [String], priorReports: [String]) {
        self.email = email
        self.password = password
        self.childName = childName
        self.age = age
        self.specialEducationNeed = specialEducationNeed
        self.priorActivities = priorActivities
        self.priorReports = priorReports
    }
}
struct SectionView<Content: View>: View {
    var title: String
    var content: () -> Content

    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(title)
                .font(.system(size: 20, weight: .bold)) // Adjust size and weight as needed
                .foregroundColor(.black)
                .multilineTextAlignment(.center)

            content()
        }
    }
}

struct ProfileView: View {
    @Binding var user: User
    @Binding var users: [User]
    @Binding var isProfileSheetPresented: Bool
    @Binding var isUserLoggedIn: Bool

    var body: some View {
        NavigationView {
            VStack {
                Image("child_image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()

                VStack(alignment: .leading, spacing: 10) { // Adjusted spacing here
                    Text("Child's Name: \(user.childName)")
                        .font(.title)
                        .foregroundColor(.black)

                    Text("Age: \(user.age)")
                        .font(.headline)
                        .foregroundColor(.black)

                    Text("Special Education Need: \(user.specialEducationNeed)")
                        .font(.headline)
                        .foregroundColor(.black)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Prior Activities Attended:")
                            .font(.headline)
                            .foregroundColor(.black)

                        ForEach(user.priorActivities, id: \.self) { activity in
                            Text(activity)
                                .foregroundColor(.black)
                        }
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Prior Reports:")
                            .font(.headline)
                            .foregroundColor(.black)

                        ForEach(user.priorReports, id: \.self) { report in
                            Text(report)
                                .foregroundColor(.black)
                        }
                    }
                }
                .padding()
                .foregroundColor(.black)
                .background(Color.green.opacity(0.2))
                .cornerRadius(15)
                .padding()

                Spacer()

                NavigationLink(destination: RecommendationView(users: $users, user: $user, isUserLoggedIn: $isUserLoggedIn, isProfileSheetPresented: $isProfileSheetPresented)) {
                    Text("Recommendation")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .cornerRadius(10)
                        .padding()
                }

                Button(action: {
                    isUserLoggedIn = false
                    isProfileSheetPresented.toggle()
                }) {
                    Text("Log Out")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding()
                }
            }
            .navigationBarHidden(true)
            .padding()
        }
    }
}

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @Binding var users: [User]
    @Binding var isUserLoggedIn: Bool
    @Binding var isRegisterSheetPresented: Bool

    var body: some View {
        VStack {
            Spacer()

            Image("nest_logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
                .padding(.bottom, 30)

            Text("Welcome back!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()

            VStack(spacing: 20) {
                // Email Field
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress) // Set keyboard type to email address
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)

                // Password Field
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)

                // Login Button
                Button(action: {
                    // Perform login action
                    isUserLoggedIn = true
                    isRegisterSheetPresented = false // Dismiss the login sheet
                }) {
                    Text("Log In")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                // Register Button
                NavigationLink(destination: RegisterView(users: $users, isRegisterSheetPresented: $isRegisterSheetPresented)) {
                    Text("Register")
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                }

                // Login with Apple ID Button
                SignInWithAppleButton(
                    onRequest: { request in
                        // Handle ASAuthorizationAppleIDRequest
                    },
                    onCompletion: { result in
                        // Handle Result<ASAuthorization, Error>
                    }
                )
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white) // Add a background to match the style
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .onTapGesture {
                    // Handle ASAuthorizationAppleIDRequest and Result<ASAuthorization, Error>
                    // You can use the provided onRequest and onCompletion closures
                }

                // Login with Google Account Button
                Button(action: {
                    // Perform login with Google action
                }) {
                    HStack {
                        Image("google_icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 20)
                        Text("Log In with Google")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
                .onTapGesture {
                    // Handle login with Google action
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .background(Color.gray.opacity(0.1).ignoresSafeArea())
    }
}

struct RecommendationView: View {
    @Binding var users: [User]
    @Binding var user: User
    @Binding var isUserLoggedIn: Bool
    @Binding var isProfileSheetPresented: Bool

    @State private var filter: String = ""
    @State private var isFilterVisible = false
    @State private var selectedFilter: FilterCriteria = .name

    enum FilterCriteria: String, CaseIterable {
        case name = "Name"
        case rating = "Rating"
        case price = "Price"
        case location = "Location"
        case personalized = "Personalized"
    }

    var activities: [Activity] = [
        // Special education needs activities in Hong Kong
        Activity(name: "Sensory Play Workshop", rating: 4, price: 18.99, location: "Hong Kong", imageName: "sensoryPlay", personalized: true,
                 details: ActivityDetail(image: "sensoryPlay", description: "Engage in a hands-on sensory play experience to stimulate various senses.",
                                         time: "10:00 AM - 12:00 PM", date: "2024-03-15", participants: 20, organization: "Sensory Explorers", location: "123 Sensory Street, Hong Kong",
                                         mapLocation: CLLocationCoordinate2D(latitude: 22.2795, longitude: 114.1725),
                                         reviews: ["Great workshop for sensory exploration!", "My child loved it!"])),
        
        Activity(name: "Art Therapy Session", rating: 5, price: 24.99, location: "Hong Kong", imageName: "artTherapy", personalized: true,
                 details: ActivityDetail(image: "artTherapy", description: "Express yourself through the power of art therapy and creativity.",
                                         time: "2:00 PM - 4:00 PM", date: "2024-03-18", participants: 15, organization: "Artistic Minds", location: "456 Artistic Avenue, Hong Kong",
                                         mapLocation: CLLocationCoordinate2D(latitude: 22.3080, longitude: 114.1880),
                                         reviews: ["A therapeutic and enjoyable session!", "Highly recommended!"])),

        Activity(name: "Adaptive Sports Day", rating: 5, price: 15.99, location: "Hong Kong", imageName: "adaptiveSports", personalized: false,
                 details: ActivityDetail(image: "adaptiveSports", description: "Join a day filled with adaptive sports for inclusive fun and physical activity.",
                                         time: "9:00 AM - 3:00 PM", date: "2024-03-25", participants: 30, organization: "Inclusive Sports HK", location: "101 Inclusive Avenue, Hong Kong",
                                         mapLocation: CLLocationCoordinate2D(latitude: 22.3255, longitude: 114.1588),
                                         reviews: ["Fantastic sports day!", "Inclusive and well-organized."])),

        Activity(name: "Interactive Storytelling", rating: 4, price: 22.99, location: "Hong Kong", imageName: "storytelling", personalized: true,
                 details: ActivityDetail(image: "storytelling", description: "Immerse yourself in interactive storytelling sessions for a magical experience.",
                                         time: "6:00 PM - 7:30 PM", date: "2024-03-28", participants: 18, organization: "Storytellers Guild", location: "567 Story Lane, Hong Kong",
                                         mapLocation: CLLocationCoordinate2D(latitude: 22.2966, longitude: 114.1694),
                                         reviews: ["Captivating stories!", "Perfect for children of all ages."])),

        // Add more activities
    ]

    var filteredActivities: [Activity] {
        switch selectedFilter {
        case .name:
            return activities.filter { activity in
                filter.isEmpty || activity.name.localizedCaseInsensitiveContains(filter)
            }
        case .rating:
            return activities.filter { activity in
                filter.isEmpty || String(activity.rating).localizedCaseInsensitiveContains(filter)
            }
        case .price:
            return activities.filter { activity in
                filter.isEmpty || String(activity.price).localizedCaseInsensitiveContains(filter)
            }
        case .location:
            return activities.filter { activity in
                filter.isEmpty || activity.location.localizedCaseInsensitiveContains(filter)
            }
        case .personalized:
            return activities.filter { activity in
                activity.personalized
            }
        }
    }

    var sortedActivities: [Activity] {
        switch selectedFilter {
        case .name:
            return filteredActivities.sorted { $0.name < $1.name }
        case .rating:
            return filteredActivities.sorted { $0.rating > $1.rating }
        case .price:
            return filteredActivities.sorted { $0.price < $1.price }
        case .location:
            return filteredActivities.sorted { $0.location < $1.location }
        case .personalized:
            return filteredActivities
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                List(sortedActivities) { activity in
                    NavigationLink(destination: ActivityDetailView(activity: activity)) {
                        ActivityCard(activity: activity)
                    }
                    .foregroundColor(.black)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("Recommendations")
        }
    }
}

struct RegisterView: View {
    // State variables for user registration
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Binding var users: [User]
    @Binding var isRegisterSheetPresented: Bool

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Image("nest_logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 100)
                    .padding(.bottom, 30)

                Text("Create an Account")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()

                VStack(spacing: 20) {
                    // Email Field
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress) // Set keyboard type to email address
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)

                    // Password Field
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)

                    // Confirm Password Field
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)

                    // Register Button
                    Button(action: {
                        // Perform registration action
                        registerUser(email: email, password: password)
                    }) {
                        Text("Register")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)

                    // Close button
                    NavigationLink(destination: LoginView(users: $users, isUserLoggedIn: .constant(false), isRegisterSheetPresented: $isRegisterSheetPresented)) {
                        Text("Close")
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                    }
                    .padding(.horizontal)
                }
                .padding(.horizontal)

                Spacer()
            }
            .background(Color.gray.opacity(0.1).ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }

    // Function to register a new user
    func registerUser(email: String, password: String) {
        // Add logic to check if email is unique and other validation
        let newUser = User(email: email, password: password, childName: "SomeName", age: 8, specialEducationNeed: "SomeNeed", priorActivities: ["Activity1", "Activity2"], priorReports: ["Report1", "Report2"])
        users.append(newUser)
        print("User registered: \(newUser.email)")
        isRegisterSheetPresented.toggle()
    }
}

struct ActivityDetail {
    var image: String
    var description: String
    var time: String
    var date: String
    var participants: Int
    var organization: String
    var location: String
    var mapLocation: CLLocationCoordinate2D
    var reviews: [String]
}

struct Activity: Identifiable {
    var id = UUID()
    var name: String
    var rating: Int
    var price: Double
    var location: String
    var imageName: String // Image name for the activity
    var personalized: Bool // New filter criteria
    var details: ActivityDetail // Additional details

    // Add more properties as needed
}

struct ActivitiesListView: View {
    @State private var filter: String = ""
    @State private var isFilterVisible = false
    @State private var selectedFilter: FilterCriteria = .name

    enum FilterCriteria: String, CaseIterable {
        case name = "Name"
        case rating = "Rating"
        case price = "Price"
        case location = "Location"
        case personalized = "Personalized" // New filter criteria
    }

    var activities: [Activity] = [
        // Special education needs activities in Hong Kong
        Activity(name: "Sensory Play Workshop", rating: 4, price: 18.99, location: "Hong Kong", imageName: "sensoryPlay", personalized: true,
                 details: ActivityDetail(image: "sensoryPlay", description: "Engage in a hands-on sensory play experience to stimulate various senses.",
                                         time: "10:00 AM - 12:00 PM", date: "2024-03-15", participants: 20, organization: "Sensory Explorers", location: "123 Sensory Street, Hong Kong",
                                         mapLocation: CLLocationCoordinate2D(latitude: 22.2795, longitude: 114.1725),
                                         reviews: ["Great workshop for sensory exploration!", "My child loved it!"])),
        
        Activity(name: "Art Therapy Session", rating: 5, price: 24.99, location: "Hong Kong", imageName: "artTherapy", personalized: true,
                 details: ActivityDetail(image: "artTherapy", description: "Express yourself through the power of art therapy and creativity.",
                                         time: "2:00 PM - 4:00 PM", date: "2024-03-18", participants: 15, organization: "Artistic Minds", location: "456 Artistic Avenue, Hong Kong",
                                         mapLocation: CLLocationCoordinate2D(latitude: 22.3080, longitude: 114.1880),
                                         reviews: ["A therapeutic and enjoyable session!", "Highly recommended!"])),
        
        Activity(name: "Music Therapy Class", rating: 4, price: 20.99, location: "Hong Kong", imageName: "musicTherapy", personalized: false,
                 details: ActivityDetail(image: "musicTherapy", description: "Experience the healing power of music therapy in a group setting.",
                                         time: "3:30 PM - 5:30 PM", date: "2024-03-20", participants: 25, organization: "Harmony Notes", location: "789 Harmony Lane, Hong Kong",
                                         mapLocation: CLLocationCoordinate2D(latitude: 22.2670, longitude: 114.1880),
                                         reviews: ["Enjoyed the musical journey!", "Professional and caring instructors."])),

        Activity(name: "Adaptive Sports Day", rating: 5, price: 15.99, location: "Hong Kong", imageName: "adaptiveSports", personalized: false,
                 details: ActivityDetail(image: "adaptiveSports", description: "Join a day filled with adaptive sports for inclusive fun and physical activity.",
                                         time: "9:00 AM - 3:00 PM", date: "2024-03-25", participants: 30, organization: "Inclusive Sports HK", location: "101 Inclusive Avenue, Hong Kong",
                                         mapLocation: CLLocationCoordinate2D(latitude: 22.3255, longitude: 114.1588),
                                         reviews: ["Fantastic sports day!", "Inclusive and well-organized."])),

        Activity(name: "Interactive Storytelling", rating: 4, price: 22.99, location: "Hong Kong", imageName: "storytelling", personalized: true,
                 details: ActivityDetail(image: "storytelling", description: "Immerse yourself in interactive storytelling sessions for a magical experience.",
                                         time: "6:00 PM - 7:30 PM", date: "2024-03-28", participants: 18, organization: "Storytellers Guild", location: "567 Story Lane, Hong Kong",
                                         mapLocation: CLLocationCoordinate2D(latitude: 22.2966, longitude: 114.1694),
                                         reviews: ["Captivating stories!", "Perfect for children of all ages."])),

        // Add more activities
    ]
    
    var filteredActivities: [Activity] {
        switch selectedFilter {
        case .name:
            return activities.filter { activity in
                filter.isEmpty || activity.name.localizedCaseInsensitiveContains(filter)
            }
        case .rating:
            return activities.filter { activity in
                filter.isEmpty || String(activity.rating).localizedCaseInsensitiveContains(filter)
            }
        case .price:
            return activities.filter { activity in
                filter.isEmpty || String(activity.price).localizedCaseInsensitiveContains(filter)
            }
        case .location:
            return activities.filter { activity in
                filter.isEmpty || activity.location.localizedCaseInsensitiveContains(filter)
            }
        case .personalized:
            return activities.filter { activity in
                activity.personalized
            }
        }
    }

    var sortedActivities: [Activity] {
        switch selectedFilter {
        case .name:
            return filteredActivities.sorted { $0.name < $1.name }
        case .rating:
            return filteredActivities.sorted { $0.rating > $1.rating }
        case .price:
            return filteredActivities.sorted { $0.price < $1.price }
        case .location:
            return filteredActivities.sorted { $0.location < $1.location }
        case .personalized:
            return filteredActivities
        }
    }

    var body: some View {
            NavigationView {
                VStack {
                    TextField("Search activities", text: $filter)
                        .padding(12)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)

                    Button("Filter") {
                        withAnimation {
                            isFilterVisible.toggle()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 12)
                    .padding(12)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(15)

                    if isFilterVisible {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)], spacing: 16) {
                            ForEach(FilterCriteria.allCases, id: \.self) { criteria in
                                let isPersonalized = criteria == .personalized
                                Button(action: {
                                    selectedFilter = criteria
                                    isFilterVisible.toggle()
                                }) {
                                    Text(criteria.rawValue)
                                        .padding(12)
                                        .foregroundColor(selectedFilter == criteria ? .white : (isPersonalized ? .red : .pink))
                                        .background(selectedFilter == criteria ? Color.pink : Color.white)
                                        .frame(maxWidth: isPersonalized ? .infinity : UIScreen.main.bounds.width / 2)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .transition(.move(edge: .bottom))
                    }

                    List(sortedActivities) { activity in
                        NavigationLink(destination: ActivityDetailView(activity: activity)) {
                            ActivityCard(activity: activity)
                        }
                        .foregroundColor(.black)
                    }
                    .listStyle(PlainListStyle())
                }
                .navigationTitle("Activities")
            }
        }
    }

    struct ActivityCard: View {
        var activity: Activity

        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Image(activity.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 150)
                    .clipped()

                Text(activity.name)
                    .font(.headline)
                    .foregroundColor(.primary)

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                    Text("Rating: \(activity.rating)")
                        .foregroundColor(.gray)
                    Spacer()
                    Text(String(format: "$%.2f", activity.price))
                        .foregroundColor(.green)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 5)
        }
    }

struct ActivityDetailView: View {
    @State private var rating: Int = 0
    @State private var review: String = ""

    var activity: Activity

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(activity.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
                    .clipped()

                VStack(alignment: .leading, spacing: 8) {
                    Text(activity.name)
                        .font(.title)
                        .foregroundColor(.primary)

                    Text("Rating: \(activity.rating)")
                        .foregroundColor(.gray)

                    Text(String(format: "$%.2f", activity.price))
                        .font(.headline)
                        .foregroundColor(.green)
                }
                .padding(.horizontal)

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Text("Description:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)

                    Text(activity.details.description)
                        .foregroundColor(.secondary)
                }
                .padding()

                VStack(alignment: .leading, spacing: 16) {
                    Text("Details:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)

                    HStack {
                        Text("Time: \(activity.details.time)")
                        Spacer()
                        Text("Date: \(activity.details.date)")
                    }

                    HStack {
                        Text("Participants: \(activity.details.participants)")
                        Spacer()
                        Text("Organization: \(activity.details.organization)")
                    }

                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: activity.details.mapLocation, latitudinalMeters: 5000, longitudinalMeters: 5000)))
                        .frame(height: 200)
                        .cornerRadius(10)
                        .padding(.vertical, 8)

                    Text("Location: \(activity.details.location)")
                }
                .padding()

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Text("Reviews:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)

                    ForEach(activity.details.reviews, id: \.self) { review in
                        Text(review)
                    }
                }
                .padding()

                Divider()

                VStack(alignment: .leading, spacing: 16) {
                    Text("Rate and Review:")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)

                    // Rating
                    HStack {
                        Text("Your Rating:")
                            .foregroundColor(.primary)

                        Spacer()

                        ForEach(1..<6) { index in
                            Image(systemName: index <= rating ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .onTapGesture {
                                    rating = index
                                }
                        }
                    }
                    .padding()

                    // Review Text Field
                    TextField("Write your review here", text: $review)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    // Submit Button
                    Button(action: {
                        // Perform submit action (you can handle rating and review submission logic here)
                    }) {
                        Text("Submit Review")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
            }
            .padding()
            .navigationTitle(activity.name)
        }
    }
}

struct BlogView: View {
    var body: some View {
        NavigationView {
            VStack {
                // "Create" Button on the Top Right
                HStack {
                    Spacer()
                    NavigationLink(destination: CreateBlogView()) {
                        Text("Create")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.trailing)
                }

                // Existing blog content
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(exampleBlogs) { blog in
                            NavigationLink(destination: BlogDetail(blog: blog)) {
                                BlogCard(blog: blog)
                                    .padding(.horizontal, 16)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            .navigationBarTitle("Blog")
        }
    }
}

struct CreateBlogView: View {
    @State private var blogTitle = ""
    @State private var blogContent = ""

    var body: some View {
        VStack {
            // Your UI for creating a blog goes here

            // Example: TextFields for Blog Title and Content
            TextField("Blog Title", text: $blogTitle)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)

            TextEditor(text: $blogContent)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 2)

            // Button to Save the Blog
            Button(action: {
                // Implement logic to save the blog
                saveBlog()
            }) {
                Text("Save Blog")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationBarTitle("Create Blog", displayMode: .inline)
    }

    // Function to save the blog
    func saveBlog() {
        // Implement the logic to save the blog, e.g., update your data model
        // You can access the entered data using blogTitle and blogContent
    }
}

struct BlogCard: View {
    var blog: Blog

    var body: some View {
        VStack(alignment: .leading) {
            Image(blog.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .clipped()

            Text(blog.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top, 8)

            Text(blog.author)
                .foregroundColor(.gray)

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 4)
    }
}

struct BlogDetail: View {
    var blog: Blog

    var body: some View {
        ScrollView {
            VStack {
                Image(blog.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()

                Text(blog.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()

                Text(blog.content)
                    .foregroundColor(.black)
                    .padding()

                Spacer()
            }
            .padding()
        }
        .navigationTitle(blog.title)
    }
}

struct Blog: Identifiable {
    var id = UUID()
    var title: String
    var author: String
    var content: String
    var imageName: String
}

let exampleBlogs: [Blog] = [
    Blog(
            title: "Understanding Autism",
            author: "John Doe",
            content: """
            Autism, a neurodevelopmental disorder, manifests in a spectrum of behaviors, communication styles, and social interactions. This diversity among individuals with autism spectrum disorder (ASD) challenges us to embrace a comprehensive understanding, fostering a society that champions inclusivity and support.

            One key aspect of understanding autism involves recognizing the spectrum's vastness. ASD encompasses a wide range of strengths and challenges, from exceptional cognitive abilities to unique sensory experiences. While some individuals may excel in areas like mathematics or music, they may face difficulties in social interactions or communication.

            Communication, indeed, stands as a pivotal component in understanding and supporting those with autism. Many individuals on the spectrum may communicate differently, with some relying on non-verbal cues or assistive communication devices. Patience and active listening become essential tools in bridging communication gaps, allowing for meaningful connections to flourish.

            Sensory sensitivity is another facet central to autism. The world, as experienced by someone with ASD, might be a symphony of intense sights, sounds, and textures. Recognizing and accommodating these sensory differences can significantly enhance the comfort and well-being of individuals on the spectrum.

            Moreover, dispelling myths surrounding autism is crucial for fostering an inclusive environment. Autism is not a singular experience but a diverse tapestry of abilities and challenges. Rather than perceiving autism through a deficit lens, embracing neurodiversity encourages a celebration of unique perspectives and talents.

            Understanding autism requires a collective effort. Educating ourselves and others, promoting acceptance, and advocating for accessible resources and support services are steps toward creating a more inclusive society. By dismantling stereotypes and fostering understanding, we can ensure that individuals with autism are valued for their contributions and lead fulfilling lives.

            In conclusion, understanding autism goes beyond acknowledging differences; it entails embracing diversity, fostering open communication, and championing inclusivity. By doing so, we create a world where everyone, regardless of where they fall on the spectrum, can thrive and contribute meaningfully to our shared human experience.
            """,
            imageName: "blog1"
        ),
    Blog(title: "Inclusive Education Strategies", author: "Jane Smith", content: "Lorem ipsum...", imageName: "blog2"),
    Blog(title: "Effective Communication with Special Needs Children", author: "Alex Johnson", content: "Lorem ipsum...", imageName: "blog3")
]

#Preview {
    ContentView()
}
