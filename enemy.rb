class Enemy < Sprite
    def initialize(x,angle,enemy_img,hp) 
      self.x = x
      self.y = 20
      @angle = angle
      @hp=hp
      self.angle = 180*@angle/Math::PI
      self.image=enemy_img
      super
    end
    def hit
      @hp-=1
      if @hp <= 0
        if $boss_stage == 1
          $boss_stage = 0
        end
        self.vanish
      end
    end
    def update
      self.x += Math.cos(@angle)*3
      self.y += Math.sin(@angle)*3
    end
end