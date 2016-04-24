
struct CollisionCategories{
    static let puckCol : UInt32 = 0x1 << 0
    static let malCol : UInt32 = 0x1 << 1
    static let topCol: UInt32 = 0x1 << 2
    static let botCol: UInt32 = 0x1 << 3
    static let boardCol: UInt32 = 0x1 << 4
    static let powerupCol: UInt32 = 0x1 << 5
    }

let GOALS_WHEN_GAME_OVER: Int = 7
let GAME_OVER: String = "GAME_OVER" // Selector name for both player's score observer
let TIME_OUT: String = "TIME_OUT"
let GAME_TIME: Double = 90 // seconds
enum GameMode {
    case TimeBased
    case GoalBased
}