class Bullet < Sprite
    @@sound2 = Sound.new("image/bom01.wav")
    def initialize(x, y, image) # 追加
      self.x=x
      self.y=y
      self.image=image
      super
    end
  
    def update
      self.y -= 5
    end
  
    def shot
      self.vanish
      @@sound2.play
    end
  end