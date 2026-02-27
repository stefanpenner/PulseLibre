import SwiftUI

struct ActionButtonView: View {
    @ObservedObject var vm: SessionViewModel

    var body: some View {
        if vm.isRunning || vm.isPaused {
            // Running or paused: show pause/resume + stop
            HStack(spacing: 12) {
                Button(action: { vm.isPaused ? vm.resume() : vm.pause() }) {
                    HStack(spacing: 8) {
                        Image(systemName: vm.isPaused ? "play.fill" : "pause.fill")
                        Text(vm.isPaused ? "Resume" : "Pause")
                            .font(.title3.weight(.bold))
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                }
                .glassEffect(
                    .regular.tint(vm.isPaused ? Theme.accentTeal : Theme.accentAmber).interactive(),
                    in: .capsule
                )
                .disabled(vm.isPaused && !vm.ble.isConnected)

                Button(action: { vm.stop() }) {
                    HStack(spacing: 8) {
                        Image(systemName: "stop.fill")
                        Text("Stop")
                            .font(.title3.weight(.bold))
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                }
                .glassEffect(.regular.tint(Theme.accentRed).interactive(), in: .capsule)
            }
        } else {
            // Idle: scan or start
            Button(action: handleTap) {
                HStack(spacing: 10) {
                    if vm.ble.isScanning {
                        ProgressView()
                            .tint(.white)
                    }
                    Text(buttonLabel)
                        .font(.title3.weight(.bold))
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
            }
            .glassEffect(.regular.tint(buttonTint).interactive(), in: .capsule)
            .disabled(vm.ble.isScanning)
            .opacity(vm.ble.isScanning ? 0.7 : 1)
        }
    }

    private var buttonLabel: String {
        if !vm.ble.isConnected {
            return vm.ble.isScanning ? "Scanning..." : "Scan for Device"
        }
        return "Start"
    }

    private var buttonTint: Color {
        if !vm.ble.isConnected { return Theme.accentBlue }
        return Theme.accentTeal
    }

    private func handleTap() {
        if !vm.ble.isConnected {
            vm.scan()
        } else {
            vm.start()
        }
    }
}
