import SwiftUI

struct ContentView: View {
    @StateObject private var vm = SessionViewModel()

    var body: some View {
        ZStack {
            Theme.backgroundGradient
                .ignoresSafeArea()

            GlassEffectContainer {
                VStack(spacing: 20) {
                    StatusBarView(vm: vm)
                    ModePicker(vm: vm)
                    ModeDescriptionView(mode: vm.selectedMode)
                        .animation(.default, value: vm.selectedMode)
                    if vm.selectedMode == .calm && vm.isRunning {
                        BreathingGuideView(vm: vm)
                    } else {
                        TimerCardView(vm: vm)
                    }
                    StrengthCardView(vm: vm)
                    Spacer()
                    ActionButtonView(vm: vm)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 40)
            }
        }
        .preferredColorScheme(.dark)
    }
}

private struct ModeDescriptionView: View {
    let mode: StimulationMode

    var body: some View {
        VStack(spacing: 6) {
            Text(mode.summary)
                .font(.caption)
                .foregroundStyle(Theme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)

            if !mode.researchLinks.isEmpty {
                VStack(spacing: 3) {
                    Text("Research · Evidence: \(mode.evidenceLevel)")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(mode.accentColor.opacity(0.8))

                    ForEach(mode.researchLinks, id: \.url) { link in
                        if let url = URL(string: link.url) {
                            Link(destination: url) {
                                Text(link.label)
                                    .font(.caption2)
                                    .foregroundStyle(Theme.accentBlue.opacity(0.8))
                                    .underline()
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
