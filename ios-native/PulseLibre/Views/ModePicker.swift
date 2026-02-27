import SwiftUI

struct ModePicker: View {
    @ObservedObject var vm: SessionViewModel

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(StimulationMode.allCases) { mode in
                    ModeCard(
                        mode: mode,
                        isSelected: vm.selectedMode == mode,
                        action: { vm.selectMode(mode) }
                    )
                }
            }
            .padding(.horizontal, 4)
        }
        .disabled(vm.isRunning || vm.isPaused)
        .opacity(vm.isRunning || vm.isPaused ? 0.5 : 1)
    }
}

private struct ModeCard: View {
    let mode: StimulationMode
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 6) {
                Image(systemName: mode.icon)
                    .font(.title3)
                    .frame(height: 24)

                Text(mode.name)
                    .font(.caption2.weight(.medium))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .foregroundStyle(isSelected ? .white : Theme.textSecondary)
            .frame(width: 72, height: 64)
            .glassEffect(
                isSelected
                    ? .regular.tint(mode.accentColor)
                    : .regular,
                in: RoundedRectangle(cornerRadius: 14)
            )
        }
        .buttonStyle(.plain)
    }
}
