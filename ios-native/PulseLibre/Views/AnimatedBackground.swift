import SwiftUI

struct AnimatedBackground: View {
    var feeling: AutonomicState?

    private static let base = Color(hex: 0x0A0E1A)

    private var meshColors: [Color] {
        guard let accent = feeling?.accentColor else {
            let mid1 = Color(hex: 0x0D1225)
            let mid2 = Color(hex: 0x0F1A2E)
            let mid3 = Color(hex: 0x162040)
            let mid4 = Color(hex: 0x0E1628)
            let mid5 = Color(hex: 0x111B30)
            return [
                Self.base, mid1,      Self.base,
                mid2,      mid3,      mid4,
                Self.base, mid5,      Self.base,
            ]
        }
        let tintLight = accent.opacity(0.15)
        let tintFaint = accent.opacity(0.07)
        return [
            Self.base,  tintFaint,  Self.base,
            tintFaint,  tintLight,  tintFaint,
            Self.base,  tintFaint,  Self.base,
        ]
    }

    var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 30)) { timeline in
            let t = timeline.date.timeIntervalSinceReferenceDate
            let pts = Self.meshPoints(t: t)
            let colors = meshColors
            MeshGradient(width: 3, height: 3, points: pts, colors: colors)
        }
        .animation(.easeInOut(duration: 0.8), value: feeling)
    }

    private static func meshPoints(t: Double) -> [SIMD2<Float>] {
        let slow = t * 0.15
        let s1 = Float(sin(slow))
        let c1 = Float(cos(slow * 0.7))
        let s2 = Float(sin(slow * 1.3))
        let c2 = Float(cos(slow * 0.9))
        let d: Float = 0.08

        return [
            SIMD2(0.0, 0.0),
            SIMD2(0.5 + s1 * d, 0.0),
            SIMD2(1.0, 0.0),

            SIMD2(0.0 + c2 * d, 0.5 + s2 * d),
            SIMD2(0.5 + c1 * d, 0.5 + s1 * d),
            SIMD2(1.0 - c2 * d, 0.5 - s1 * d),

            SIMD2(0.0, 1.0),
            SIMD2(0.5 - s2 * d, 1.0),
            SIMD2(1.0, 1.0),
        ]
    }
}
