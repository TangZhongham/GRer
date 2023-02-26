//
//  FiltersAlbum.swift
//  GRer
//
//  Created by 唐某某 on 2023/2/26.
//

import SwiftUI
import MediaCore
import MediaSwiftUI

struct FiltersAlbum: View {
    private enum PermissionState: Equatable {
        case granted
        case loading
        case failed(_ error: NSError)
    }
    
    @State private var lazyUserAlbums: LazyAlbums?
    @State private var userAlbums: [Album] = []
    @State private var permissionState: PermissionState = .loading
    
    @FetchAssets(sort: [Media.Sort(key: .creationDate, ascending: true)])
    private var videos: [Video]
    
    @FetchAlbums(ofType: .smart)
    private var albums: [Album]
    
    var body: some View {
        NavigationView {
            switch permissionState {
            case .loading:
                ProgressView()
                    .onAppear {
                        if !Media.isAccessAllowed {
                            requestPermission()
                        } else {
                            permissionState = .granted
                            fetchAlbums()
                        }
                    }
            case .granted:
                List {
                    PermissionsSection(requestedPermission: handleRequestPermissionResult)
                    
                    Section(header: Text("Property wrapper")) {
                        NavigationLink(destination: VideosView(videos: videos)) {
                            Text("@FetchAssets videos")
                        }
                        
                        NavigationLink(destination: AlbumsView(albums: albums)) {
                            Text("@FetchAlbums smart")
                        }
                    }
                    
                    Section(header: Label("Albums", systemImage: "person.2.square.stack")) {
                        NavigationLink(destination: AlbumsView(albums: userAlbums)) {
                            Text("User albums (\(userAlbums.count))")
                        }
                        
                        NavigationLink(destination: AlbumsView(albums: cloudAlbums)) {
                            Text("Cloud albums (\(cloudAlbums.count))")
                        }
                        
                        NavigationLink(destination: AlbumsView(albums: smartAlbums)) {
                            Text("Smart albums (\(smartAlbums.count))")
                        }
                        
                        if let userAlbums = lazyUserAlbums {
                            let item = Item.albums(albums: userAlbums)
                            NavigationLink(destination: ScrollView {
                                LazyTree(node: item, children: \.children)
                            }) {
                                Text("Lazy Tree (with user albums)")
                            }
                            
                            NavigationLink(destination: LazyAlbumsView(albums: userAlbums)) {
                                Text("Lazy User albums (\(userAlbums.count))")
                            }
                        }
                    }
                    
                    PhotosSection()
                    
                    VideosSection()
                    
                    CameraSection()
                    
                    BrowserSection()
                }
                .listStyle(InsetGroupedListStyle())
                .navigationBarTitle("Examples")
            case let .failed(error):
                VStack(spacing: 20) {
                    Text(error.localizedDescription)
                    
                    Button(action: requestPermission) {
                        Text("Trigger photo library permission request")
                    }
                }
            }
        }
    }
}

private extension FiltersAlbum {
    func requestPermission() {
        Media.requestPermission(handleRequestPermissionResult)
    }
    
    func handleRequestPermissionResult(_ result: Result<Void, PermissionError>) {
        switch result {
        case .success:
            permissionState = .granted
            fetchAlbums()
        case .failure(let error):
            permissionState = .failed(error as NSError)
        }
    }
    
    func fetchAlbums() {
        lazyUserAlbums = LazyAlbums.user
        userAlbums = Albums.user
    }
}

struct FiltersAlbum_Previews: PreviewProvider {
    static var previews: some View {
        FiltersAlbum()
    }
}
