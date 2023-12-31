//
//  ContentView.swift
//  LearningApp
//
//  Created by Christopher Ching on 2021-03-03.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        NavigationView {
            VStack (alignment: .leading) {
                Text("What do you want to do today???")
                    .padding(.leading, 20)
                
                ScrollView {
                    
                    LazyVStack {
                        
                        ForEach(model.modules) { module in
                            
                            VStack (spacing: 20) {
                                
                                NavigationLink(
                                    destination:
                                        ContentView()
                                            .onAppear(perform: {
                                                model.beginModule(module.id)
                                            }),
                                    tag: module.id,
                                    selection: $model.currentContentSelected) {
                                    
                                        // Learning Card
                                        HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                        
                                    }
                                
                                NavigationLink(
                                    destination:
                                        TestView()
                                            .onAppear(perform: {
                                            model.beginTest(module.id)
                                        }),
                                    tag: module.id,
                                    selection: $model.currentTestSelected) {
                                    
                                    // Test Card
                                    HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Lessons", time: module.test.time)
                                }
                                
                                
                                
                            }
                            .padding(.bottom, 10)
                        }
                        
                    }
                    .accentColor(.black)
                    .padding()
                    
                }
            }
            .navigationTitle("Get Started")
            .onChange(of: model.currentContentSelected) { changedValue in
                if changedValue == nil {
                    model.currentModule = nil
                }
            }
            .onChange(of: model.currentTestSelected) { changedValue in
                if changedValue == nil {
                    model.currentModule = nil
                }
            }
        }
        .navigationViewStyle(.stack) // in XCode 13, we must add this new modifier (we must specify the style of navigation for the NavigationView). This is to fix the issue of "when you drill down into a lesson, it automatically pops back out."
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
