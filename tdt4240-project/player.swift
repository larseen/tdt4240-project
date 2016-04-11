


import SpriteKit


class Player{
    
    var position:Int = 0
    var score:Int = 0;

    let scoreLabel: SKLabelNode! = nil
    let nameLabel: SKLabelNode! = nil
    
    
    init(){
        
    }
    
    
    func setPosition(position:Int){
        self.position = position
    }
    
    func getPosition() -> Int{
        return self.position
    }
    
    func addPoints(points:Int){
        self.score += points
        
    }
    
    func getScore()-> Int{
        return self.score
        
    }
    
    func setPlayerName(playerName:String){
        nameLabel.text = playerName
    }
    
    
    
    
}