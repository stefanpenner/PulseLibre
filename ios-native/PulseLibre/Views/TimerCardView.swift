import SwiftUI

struct TimerCardView: View {
    @ObservedObject var vm: SessionViewModel

    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 2) {
                Text("Session Timer")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Theme.textSecondary)

                if vm.selectedMode != .custom {
                    Text(vm.selectedMode.name)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(vm.selectedMode.accentColor)
                }
            }

            HStack(spacing: 32) {
                // Minus button
                Button {
                    vm.decreaseTimer()
                } label: {
                    Image(systemName: "minus")
                        .font(.title2.weight(.medium))
                        .frame(width: 52, height: 52)
                }
                .glassEffect(.regular.interactive(), in: .circle)
                .disabled(vm.isRunning || vm.isPaused)
                .opacity(vm.isRunning || vm.isPaused ? 0.3 : 1)

                // Time display
                VStack(spacing: 10) {
                    Text(vm.displayTime)
                        .font(.system(size: 56, weight: .bold, design: .monospaced))
                        .foregroundStyle(vm.isPaused ? Theme.textSecondary : Theme.textPrimary)
                        .contentTransition(.numericText())
                        .animation(.default, value: vm.remainingSeconds)

                    // Progress bar
                    if vm.isRunning || vm.isPaused {
                        GeometryReader { geo in
                            Capsule()
                                .fill(Color.white.opacity(0.15))
                                .frame(height: 4)
                                .overlay(alignment: .leading) {
                                    Capsule()
                                        .fill(Theme.accentTeal)
                                        .shadow(color: Theme.accentTeal.opacity(0.5), radius: 4)
                                        .frame(width: geo.size.width * vm.progress)
                                        .animation(.linear(duration: 1), value: vm.progress)
                                }
                        }
                        .frame(height: 4)
                    }

                    // Mode status
                    if (vm.isRunning || vm.isPaused) && !vm.modeStatus.isEmpty {
                        Text(vm.isPaused ? "Paused" : vm.modeStatus)
                            .font(.caption.weight(.medium))
                            .foregroundStyle(vm.isPaused ? Theme.accentAmber : vm.selectedMode.accentColor)
                            .contentTransition(.opacity)
                            .animation(.default, value: vm.modeStatus)
                    }
                }
                .frame(minWidth: 180)

                // Plus button
                Button {
                    vm.increaseTimer()
                } label: {
                    Image(systemName: "plus")
                        .font(.title2.weight(.medium))
                        .frame(width: 52, height: 52)
                }
                .glassEffect(.regular.interactive(), in: .circle)
                .disabled(vm.isRunning || vm.isPaused)
                .opacity(vm.isRunning || vm.isPaused ? 0.3 : 1)
            }
        }
        .padding(24)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 20))
    }
}
