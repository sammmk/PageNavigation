//
//  ContentView.swift
//  PageNavigation
//
//  Created by Mohan Kurera on 2024/04/17.
//

import SwiftUI

enum pageType: Int, CaseIterable {
    case page1 = 1
    case page2 = 2
    case page3 = 3
    case page4 = 4

    var title: String {
        switch self {
        case .page1:
            return "page1"
        case .page2:
            return "page2"
        case .page3:
            return "page3"
        case .page4:
            return "page4"
        }
    }
}

struct ContentView: View {
    @State var selectedPage: pageType = .page1
    @State var isBack: Bool = false

    var body: some View {

        VStack {
            HStack {
                ForEach(pageType.allCases, id: \.self) { page in
                    Button(action: {
                        if page.rawValue > selectedPage.rawValue {
                            isBack = false
                        }
                        else if page.rawValue < selectedPage.rawValue {
                            isBack = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                            self.selectedPage = page
                        }
                    }) {
                        Text("\(page.title)")
                    }
                }
            }

            Group {
                switch selectedPage {
                case .page1:
                    PageView(name: "First page", color: .brown)
                case .page2:
                    PageView(name: "Second page", color: .blue)
                case .page3:
                    PageView(name: "Third page", color: .red)
                case .page4:
                    PageView(name: "Forth page", color: .green)
                }
            }
            .transition(AnyTransition.asymmetric(
                insertion:.move(edge: isBack ? .leading : .trailing),
                removal: .move(edge: isBack ? .trailing : .leading))
            )
            .animation(.default, value: self.selectedPage)
        }
    }
}

struct PageView: View {
    var name: String
    var color: UIColor
    var body: some View {
        HStack {
            Spacer()
            Text(name)
            Spacer()
        }
        .padding()
        .padding(.vertical, 50)
        .background(Color(color))
    }
}
#Preview {
    ContentView()
}
