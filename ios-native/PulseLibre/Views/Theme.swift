import SwiftUI
import UIKit

enum Theme {
    // MARK: - Adaptive helper

    static func adaptive(light: UInt, dark: UInt) -> Color {
        Color(UIColor { traits in
            traits.userInterfaceStyle == .dark
                ? UIColor(Color(hex: dark))
                : UIColor(Color(hex: light))
        })
    }

    // Background gradient
    static let backgroundTop = adaptive(light: 0xF5F0E8, dark: 0x0A0E1A)
    static let backgroundBottom = adaptive(light: 0xEDE7DB, dark: 0x141B2D)

    // Accent colors
    static let accentTeal = Color(hex: 0x00E5CC)
    static let accentBlue = Color(hex: 0x4A90E2)
    static let accentRed = Color(hex: 0xEF4444)

    // Mode accent colors
    static let accentPurple = Color(hex: 0xA855F7)
    static let accentAmber = Color(hex: 0xF59E0B)
    static let accentCyan = Color(hex: 0x06B6D4)

    // Text
    static let textPrimary = adaptive(light: 0x1A1A2E, dark: 0xFFFFFF)
    static let textSecondary = adaptive(light: 0x5A5A6E, dark: 0x9CA3AF)
    static let textTertiary = adaptive(light: 0x8A8A9E, dark: 0x6B7280)

    // Glass overlay
    static let glassOverlay = Color(UIColor { traits in
        traits.userInterfaceStyle == .dark
            ? UIColor(white: 1.0, alpha: 0.1)
            : UIColor(white: 0.0, alpha: 0.06)
    })

    // Status
    static let connectedGreen = Color(hex: 0x10B981)
    static let disconnectedRed = Color(hex: 0xEF4444)

    // Background gradient
    static var backgroundGradient: LinearGradient {
        LinearGradient(
            colors: [backgroundTop, backgroundBottom],
            startPoint: .top,
            endPoint: .bottom
        )
    }

    // MARK: - Type Scale

    /// Section headers: "SESSION TIMER", "INTENSITY LEVEL"
    static let sectionLabel = Font.caption.weight(.semibold).width(.expanded)
    /// Card subtitles: mode name, effective strength
    static let cardSubtitle = Font.caption2.weight(.medium)
    /// Hero numbers: timer display
    static let heroTimer = Font.system(size: 54, weight: .light, design: .monospaced)
    /// Large numbers: strength badge
    static let heroNumber = Font.system(size: 30, weight: .semibold, design: .rounded)
    /// Mode status text
    static let statusLabel = Font.caption.weight(.medium)
    /// Button text
    static let buttonLabel = Font.body.weight(.semibold)
    /// Breathing phase label
    static let breathingLabel = Font.title3.weight(.regular)
}

extension Color {
    init(hex: UInt, opacity: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: opacity
        )
    }
}
