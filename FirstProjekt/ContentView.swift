//
//  ContentView.swift
//  PlaygroundXcode
//
//  Created by Oguzhan Cirpan on 26.03.25.
//

import SwiftUI

struct ContentView: View {
    @State private var firstname = ""
    @State private var lastname = ""
    @State private var date = Date()
    
    // Adressfelder
    @State private var location = ""
    @State private var postalCode = ""
    @State private var street = ""
    @State private var houseNumber = ""
    
    // Kontaktfelder
    @State private var email = ""
    @State private var confirmEmail = ""
    
    @State private var termsAccepted = false

    // Passwortfelder (auf derselben Seite)
    @State private var password = ""
    @State private var newPassword = ""
    @State private var confirmedPassword = ""
    private let oldPasswordToConfirmAgainst = "12345"
    
    struct Location {
        static let allLocations = ["Österreich", "Deutschland", "Schweiz"]
    }
    
    var body: some View {
        NavigationView {
            Form {
                // Persönliche Daten
                Section(header: Text("Persönliche Daten")) {
                    TextField("Vorname", text: $firstname)
                    TextField("Nachname", text: $lastname)
                }
                
                // Geburtsdatum (eigene Section)
                Section(header: Text("Geburtsdatum")) {
                    DatePicker(
                        "Geburtsdatum",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                }
                
                // Adresse
                Section(header: Text("Adresse")) {
                    Picker(selection: $location, label: Text("Land")) {
                        ForEach(Location.allLocations, id: \.self) { loc in
                            Text(loc).tag(loc)
                        }
                    }
                    TextField("Bundesland", text: $postalCode)
                    TextField("Ort                                /                            PLZ", text: $street)
                    
                    TextField("Straße                          /           Hausnummer", text: $houseNumber)
                }
                
                // Kontakt
                Section(header: Text("Kontakt")) {
                    TextField("E-Mail", text: $email)
                        .keyboardType(.emailAddress)
                    TextField("E-Mail bestätigen", text: $confirmEmail)
                        .keyboardType(.emailAddress)
                }
                
                // Allgemeine Geschäftsbedingungen
                Section {
                    Toggle(isOn: $termsAccepted, label: {
                        Text("Allgemeine Geschäftsbedingungen akzeptieren")
                    })
                }
                
                // Profil aktualisieren
                Section {
                    if self.isUserInformationValid() {
                        Button(action: {
                            print("Profil aktualisiert")
                        }, label: {
                            Text("Profil aktualisieren")
                        })
                    }
                }
                
                // Passwortbereich
                Section(header: Text("Passwort")) {
//                    SecureField("Passwort eingeben", text: $password)
                    SecureField("Neues Passwort", text: $newPassword)
                    SecureField("Neues Passwort bestätigen", text: $confirmedPassword)
                    
                    if self.isPasswordValid() {
                        Button(action: {
                            print("Passwort aktualisiert")
                        }, label: {
                            Text("Passwort aktualisieren")
                        })
                    }
                }
            }
            .navigationBarTitle(Text("Profil"))
        }
    }
    
    // Funktion zur Validierung der Benutzerdaten
    private func isUserInformationValid() -> Bool {
        return !firstname.isEmpty &&
               !lastname.isEmpty &&
               !location.isEmpty &&
               !postalCode.isEmpty &&
               !street.isEmpty &&
               !houseNumber.isEmpty &&
               !email.isEmpty &&
               (email == confirmEmail) &&
               termsAccepted
    }
    
    // Funktion zur Validierung der Passwortfelder
    private func isPasswordValid() -> Bool {
        return password == oldPasswordToConfirmAgainst &&
               !newPassword.isEmpty &&
               newPassword == confirmedPassword
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#Preview {
    ContentView()
}
