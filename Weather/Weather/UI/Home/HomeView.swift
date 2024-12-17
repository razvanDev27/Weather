//
//  HomeView.swift
//  Weather
//
//  Created by Razvan Copaciu on 17.12.2024.
//

import SwiftUI

struct HomeView: View {

    @State private var viewModel: HomeViewModel

    init(userDataProvider: UserDataProvider) {
        self._viewModel = State(initialValue: HomeViewModel(userDataProvider: userDataProvider))
    }

    var body: some View {
        content
            .alert(isPresented: $viewModel.isError, error: viewModel.error) {
                Button {
                    viewModel.isError = false
                } label: {
                    Text("OK")
                }
            }
    }
}

private extension HomeView {
    var content: some View {
        VStack {
            searchBarView
            Spacer()

            if viewModel.isLoading {
                loadingView
            } else if let weatherLocation = viewModel.resultWeatherLocation {
                searchResultView(weatherLocation)
            } else if let weatherLocation = viewModel.selectedWeatherLocation {
                selectedWeatherView(weatherLocation)
            } else {
                emptyView
            }
        }
        .padding([.horizontal, .top], 20)
    }

    // MARK: Search Bar View

    var searchBarView: some View {
        HStack {
            searchTextField
            if !viewModel.searchText.isEmpty {
                clearButton
            }
            searchIcon
        }
        .frame(height: 46)
        .padding(.horizontal, 20)
        .background(Color.gray5)
        .clipShape(.rect(cornerRadius: 15))
    }

    var searchIcon: some View {
        Image(systemName: "magnifyingglass")
            .resizable()
            .foregroundStyle(.gray40)
            .frame(width: 16, height: 16, alignment: .center)
    }

    var searchTextField: some View {
        TextField("Search Location", text: $viewModel.searchText)
            .disableAutocorrection(true)
            .foregroundStyle(.black)
            .onChange(of: viewModel.searchText) {
                Task {
                    await viewModel.updateDebouncedText()
                }
            }
    }

    var clearButton: some View {
        Button {
            viewModel.searchText = ""
        } label: {
            Image(systemName: "x.circle.fill")
                .foregroundStyle(.black)
                .frame(width: 18, height: 18)
                .padding(.trailing, 12)
        }
    }

    // MARK: Weather View

    func searchResultView(_ weatherLocation: Weather) -> some View {
        VStack {
            Button {
                viewModel.selectWeatherLocation(weatherLocation)
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(weatherLocation.location.name)
                            .appFont(size: 20)
                            .foregroundStyle(.black)
                            .multilineTextAlignment(.leading)
                        Text("\(String(format: "%.0f", weatherLocation.current.temperature))°")
                            .appFont(size: 60)
                            .foregroundStyle(.black)
                    }
                    Spacer()

                    weatherIcon(imagePath: weatherLocation.current.condition.icon)
                        .frame(width: 83, height: 83)
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 31)
                .background(Color.gray10)
                .clipShape(.rect(cornerRadius: 16))
            }

            Spacer()
        }
    }

    func selectedWeatherView(_ weatherLocation: Weather) -> some View {
        VStack(spacing: 0) {
            Spacer()
            weatherIcon(imagePath: weatherLocation.current.condition.icon)
                .frame(width: 123, height: 123)
                .padding(.bottom, 27)

            HStack(spacing: 11) {
                Text(weatherLocation.location.name)
                    .appFont(size: 30)

                Image(systemName: "location.fill")
                    .resizable()
                    .frame(width: 22, height: 22)
            }
            .padding(.bottom, 16)

            Text("\(String(format: "%.0f", weatherLocation.current.temperature))°")
                .appFont(size: 70)
                .foregroundColor(.black)

            weatherDetailsView(weatherLocation)
                .padding(.top, 36)
            Spacer()
        }
    }

    func weatherDetailsView(_ weather: Weather) -> some View {
        HStack(spacing: 56) {
            detailView(title: "Humidity", subtitle: "\(String(format: "%.0f", weather.current.humidity))%", titleSize: 12)
            detailView(title: "UV", subtitle: "\(String(format: "%.0f", weather.current.uv))", titleSize: 12)
            detailView(title: "Feels Like", subtitle: "\(String(format: "%.0f", weather.current.temperatureFeelsLike))°", titleSize: 8)
        }
        .frame(width: 274 ,height: 75)
        .background(Color.gray5)
        .clipShape(.rect(cornerRadius: 16))
    }

    func detailView(title: String, subtitle: String, titleSize: CGFloat) -> some View {
        VStack {
            Text(title)
                .foregroundStyle(Color.gray20)
                .appFont(size: titleSize)
            Text(subtitle)
                .foregroundStyle(Color.gray40)
        }
    }

    func weatherIcon(imagePath: String) -> some View {
        AsyncImage(url: URL(string: "https:\(imagePath)")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } placeholder: {
            ProgressView()
        }
    }


    // MARK: Emprty View

    var emptyView: some View {
        VStack(spacing: 12) {
            Spacer()
            Text("No City Selected")
                .appFont(size: 30)
            Text("Please search for a city")
                .appFont(size: 15)
            Spacer()
        }
    }

    // MARK: Loading View

    var loadingView: some View {
        VStack {
            Spacer()
            ProgressView()
            Spacer()
        }
    }
}
