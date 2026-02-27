import SwiftUI

struct FeelingPicker: View {
    @ObservedObject var vm: SessionViewModel

    private var isLocked: Bool { vm.isRunning || vm.isPaused }
    private let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
    ]

    var body: some View {
        VStack(spacing: 8) {
            Text("How are you feeling?")
                .font(.caption)
                .foregroundStyle(Theme.textSecondary)

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(AutonomicState.allCases) { state in
                    FeelingCell(
                        state: state,
                        isSelected: vm.selectedFeeling == state,
                        action: { vm.selectFeeling(state) }
                    )
                }
            }
        }
        .disabled(isLocked)
        .opacity(isLocked ? 0.5 : 1)
    }
}

private struct FeelingCell: View {
    let state: AutonomicState
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: state.icon)
                    .font(.system(size: 16))
                    .frame(width: 20)

                VStack(alignment: .leading, spacing: 1) {
                    Text(state.label)
                        .font(.system(size: 13, weight: .medium, design: .rounded))
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)

                    Text(state.subtitle)
                        .font(.system(size: 10))
                        .lineLimit(1)
                        .opacity(0.7)
                }
            }
            .foregroundStyle(isSelected ? .white : Theme.textSecondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .contentShape(RoundedRectangle(cornerRadius: 12))
            .glassEffect(
                isSelected
                    ? .regular.tint(state.accentColor)
                    : .regular,
                in: RoundedRectangle(cornerRadius: 12)
            )
        }
        .buttonStyle(.plain)
    }
}
