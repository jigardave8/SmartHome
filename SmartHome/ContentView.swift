//
//  ContentView.swift
//  SmartHome
//
//  Created by Jigar on 25/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SmartLightView()
                .tabItem {
                    Image(systemName: "lightbulb")
                    Text("Smart Light")
                }
            HomeScreenView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            TemperatureControlView()
                .tabItem {
                    Image(systemName: "thermometer")
                    Text("Temperature")
                }
        }
    }
}

struct SmartLightView: View {
    @State private var brightness: Double = 64
    @State private var selectedColor: Color = .white

    var body: some View {
        VStack {
            Text("Smart Light")
                .font(.largeTitle)
                .padding(.top)
            Spacer()
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(selectedColor)
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.brightness / 100, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(selectedColor)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear)
                Text("\(Int(brightness))%")
                    .font(.largeTitle)
            }
            .frame(width: 200, height: 200)
            .padding()
            Slider(value: $brightness, in: 0...100)
                .accentColor(selectedColor)
                .padding()
            HStack {
                ForEach([Color.white, Color.red, Color.green, Color.blue, Color.yellow, Color.purple], id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 40, height: 40)
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .foregroundColor(.white)
    }
}

struct HomeScreenView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Hi Robbie")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("Welcome Home")
                        .foregroundColor(.gray)
                }
                Spacer()
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
            .padding()
            
            HStack {
                TabButton(title: "Living Room")
                TabButton(title: "Kitchen")
                TabButton(title: "Bedroom")
            }
            .padding(.horizontal)
            
            ScrollView {
                VStack(spacing: 20) {
                    MusicPlayerView()
                    AlarmView()
                    SmartLightWidget()
                    TemperatureWidget()
                }
                .padding()
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .foregroundColor(.white)
    }
}

struct TabButton: View {
    var title: String
    
    var body: some View {
        Text(title)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
    }
}

struct MusicPlayerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("People Are People")
                    .font(.title2)
                Spacer()
                Text("Depeche Mode")
                    .foregroundColor(.gray)
            }
            .padding([.top, .horizontal])
            
            Text("Now Playing")
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            HStack {
                Image(systemName: "backward.fill")
                Image(systemName: "play.fill")
                    .font(.largeTitle)
                Image(systemName: "forward.fill")
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(15)
            .padding()
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

struct AlarmView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Alarm")
                    .font(.title2)
                Spacer()
                Toggle("", isOn: .constant(true))
                    .labelsHidden()
            }
            .padding([.top, .horizontal])
            Text("07:00 Work")
                .padding(.horizontal)
                .padding(.bottom)
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

struct SmartLightWidget: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Smart Light")
                .font(.title2)
                .padding([.top, .horizontal])
            Text("Brightness 64%")
                .padding([.horizontal, .bottom])
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

struct TemperatureWidget: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Home Temperature")
                .font(.title2)
                .padding([.top, .horizontal])
            Text("Goal 24°C")
                .padding([.horizontal, .bottom])
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

struct TemperatureControlView: View {
    @State private var temperature: Double = 24

    var body: some View {
        VStack {
            Text("Home Temperature")
                .font(.largeTitle)
                .padding(.top)
            Spacer()
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(.white)
                Circle()
                    .trim(from: 0.0, to: CGFloat(min(self.temperature / 30, 1.0)))
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.white)
                    .rotationEffect(Angle(degrees: 270.0))
                    .animation(.linear)
                Text("\(Int(temperature))°C")
                    .font(.system(size: 64))
            }
            .frame(width: 200, height: 200)
            .padding()
            Slider(value: $temperature, in: 10...30)
                .accentColor(.white)
                .padding()
            HStack {
                Text("15:00")
                Spacer()
                Text("22:00")
            }
            .padding()
            Spacer()
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.8), Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
