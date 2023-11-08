import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var showWelcomeUserView = false
    @State private var showWelcomeView = false
    @State private var showAlert = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome!")
                    .font(.largeTitle)
                    .padding()

                TextField("Username", text: $username)
                    .padding()
                SecureField("Password", text: $password)
                    .padding()

                Button(action: {
                    if (username == "User" && password == "1234") {
                        showWelcomeUserView = true
                    } else if (username == "Admin" && password == "1234") {
                        showWelcomeView = true
                    } else {
                        showAlert = true
                    }
                }) {
                    Text("Sign In")
                        .font(.title)
                        .padding()
                        .frame(width: 150, height: 50)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                NavigationLink(destination: WelcomeUserView(), isActive: $showWelcomeUserView) {
                    EmptyView()
                }

                NavigationLink(destination: WelcomeView(), isActive: $showWelcomeView) {
                    EmptyView()
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Invalid Login"), message: Text("Please check your username and password."), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
