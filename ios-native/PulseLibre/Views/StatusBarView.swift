import SwiftUI

struct StatusBarView: View {
    @ObservedObject var vm: SessionViewModel

    var body: some View {
        if vm.ble.isConnected {
            connectedBar
        } else {
            disconnectedBar
        }
    }

    private var connectedBar: some View {
        HStack(spacing: 16) {
            HStack(spacing: 6) {
                Circle()
                    .fill(Theme.connectedGreen)
                    .frame(width: 8, height: 8)
                    .shadow(color: Theme.connectedGreen.opacity(0.6), radius: 4)

                Text("Connected")
                    .font(.caption2.weight(.medium))
                    .foregroundStyle(Theme.textSecondary)
            }

            Spacer()

            if let pct = vm.ble.batteryPercentage {
                HStack(spacing: 4) {
                    Image(systemName: batteryIcon(pct))
                        .font(.caption2)
                        .foregroundStyle(Theme.textSecondary)

                    if let v = vm.ble.batteryVoltage {
                        Text(String(format: "%.2fV", v))
                            .font(.caption2.monospacedDigit().weight(.medium))
                            .foregroundStyle(Theme.textTertiary)
                    }

                    Text("\(pct)%")
                        .font(.caption2.monospacedDigit().weight(.medium))
                        .foregroundStyle(Theme.textSecondary)

                    if let charging = vm.ble.isCharging, charging {
                        Image(systemName: "bolt.fill")
                            .font(.caption2)
                            .foregroundStyle(Theme.accentTeal)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .glassEffect(.regular, in: .capsule)
    }

    private var disconnectedBar: some View {
        Button(action: {
            if vm.ble.isScanning {
                vm.ble.cancelScan()
            } else {
                vm.scan()
            }
        }) {
            HStack(spacing: 8) {
                Circle()
                    .fill(vm.ble.isScanning ? Theme.accentAmber : Theme.disconnectedRed)
                    .frame(width: 8, height: 8)
                    .shadow(color: (vm.ble.isScanning ? Theme.accentAmber : Theme.disconnectedRed).opacity(0.6), radius: 4)

                if vm.ble.isScanning {
                    Text("Scanning...")
                        .font(.caption2.weight(.medium))
                        .foregroundStyle(Theme.textSecondary)

                    Spacer()

                    HStack(spacing: 4) {
                        ProgressView()
                            .tint(Theme.textSecondary)
                            .controlSize(.small)
                        Text("Cancel")
                            .font(.caption2.weight(.semibold))
                            .foregroundStyle(Theme.accentAmber)
                    }
                } else {
                    Text("Disconnected")
                        .font(.caption2.weight(.medium))
                        .foregroundStyle(Theme.textSecondary)

                    Spacer()

                    HStack(spacing: 4) {
                        Image(systemName: "antenna.radiowaves.left.and.right")
                            .font(.caption2)
                        Text("Tap to Scan")
                            .font(.caption2.weight(.semibold))
                    }
                    .foregroundStyle(Theme.accentBlue)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .contentShape(.capsule)
            .glassEffect(.regular, in: .capsule)
        }
        .buttonStyle(.plain)
    }

    private func batteryIcon(_ pct: Int) -> String {
        switch pct {
        case 0..<13: "battery.0percent"
        case 13..<38: "battery.25percent"
        case 38..<63: "battery.50percent"
        case 63..<88: "battery.75percent"
        default: "battery.100percent"
        }
    }
}
