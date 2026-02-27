import SwiftUI

struct StrengthCardView: View {
    @ObservedObject var vm: SessionViewModel

    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 2) {
                Text("Intensity Level")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(Theme.textSecondary)

                if let eff = vm.effectiveStrength, vm.isRunning {
                    Text(eff == 0 ? "Paused" : "Active: \(eff)")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(vm.selectedMode.accentColor)
                }
            }

            // Strength display with +/- buttons
            HStack(spacing: 24) {
                Button {
                    vm.setStrength(vm.strength - 1)
                } label: {
                    Image(systemName: "minus")
                        .font(.title2.weight(.medium))
                        .frame(width: 52, height: 52)
                }
                .glassEffect(.regular.interactive(), in: .circle)

                // Strength badge
                Text("\(vm.strength)")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(width: 80, height: 52)
                    .glassEffect(.regular.tint(Theme.accentBlue), in: .capsule)
                    .contentTransition(.numericText())
                    .animation(.default, value: vm.strength)

                Button {
                    vm.setStrength(vm.strength + 1)
                } label: {
                    Image(systemName: "plus")
                        .font(.title2.weight(.medium))
                        .frame(width: 52, height: 52)
                }
                .glassEffect(.regular.interactive(), in: .circle)
            }

            // Slider
            HStack(spacing: 12) {
                Text("1")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Theme.textSecondary)

                Slider(
                    value: Binding(
                        get: { Double(vm.strength) },
                        set: { vm.setStrength(Int($0.rounded())) }
                    ),
                    in: 1...9,
                    step: 1
                )
                .tint(Theme.accentBlue)

                Text("9")
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(Theme.textSecondary)
            }
        }
        .padding(24)
        .glassEffect(.regular, in: RoundedRectangle(cornerRadius: 20))
    }
}
