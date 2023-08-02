
import Foundation
import SwiftUI

public enum ProgressHUDType {
    case success
    case error
    case txt
    case loading
    case image
}

public class ProgressState: ObservableObject {
    @Published public var isPresented = false
    
    public init(isPresented: Bool = false) {
        self.isPresented = isPresented
    }
    
    private(set) var title: String = ""
    private(set) var image: Image?
    private(set) var duration = 1.5
    private(set) var type: ProgressHUDType = .loading
    
    public func show(type: ProgressHUDType = .txt,
                     title: String,
                     image: Image? = nil,
                     duration: Double? = nil) {
        self.type = type
        self.title = title
        self.image = image
        if duration != nil {
            self.duration = duration!
        }
        
        withAnimation {
            self.isPresented = true
        }
    }
    
    public func hide() {
        withAnimation {
            self.isPresented = false
        }
    }
    
}

public struct XSProgressHUD: View {
    @EnvironmentObject var progressState: ProgressState
    
    public var body: some View {
        VStack {
            switch progressState.type {
            case .txt:
                Text(progressState.title)
            case .error:
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                Text(progressState.title)
            case .success:
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 20, height: 20, alignment: .center)
                Text(progressState.title)
            case .loading:
                if #available(iOS 15.0, *) {
                    ProgressView()
                        .colorScheme(.dark)
                        .tint(.white)
                } else {
                    ProgressView()
                        .colorScheme(.dark)
                }
                Text(progressState.title)
            case .image:
                if progressState.image != nil {
                    progressState.image!
                        .resizable()
                        .frame(width: 20, height: 20, alignment: .center)
                }
                Text(progressState.title)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.black.opacity(0.9))
        )
        .foregroundColor(.white)
        #if os(macOS)
        .frame(maxWidth: 500)
        #else
        .frame(maxWidth: UIScreen.main.bounds.width - 100)
        #endif
        .onAppear {
            if progressState.type != .loading {
                DispatchQueue.main.asyncAfter(deadline: .now() + progressState.duration) {
                    progressState.hide()
                }
            }
        }
    }
    
}

extension View {
    public func ProgressHUD(isPresented: Binding<Bool>) -> some View {
        ZStack(alignment: .center) {
            Color.clear
            
            self
            
            if isPresented.wrappedValue {
                Color.black.opacity(0.3)
                
                XSProgressHUD()
                    .zIndex(1)
            }
        }
        .ignoresSafeArea()
    }
}
