class Player < Sprite
  @@sound = Sound.new("image/bom10.wav")
  attr_accessor :life

  def initialize(x, y, image) 
    @score = 0
    self.x=x
    self.y=y
    self.image=image
    super
  end

  def update
    self.x += Input.x * 5
    self.y += Input.y * 5
    if self.x > 400
      self.x -= 5
    elsif self.x < 20
      self.x += 5
    end
    if self.y > 445
      self.y -= 5
    elsif self.y < 20
      self.y += 5
    end
  end

  def shot(life)
    @life -= 1
    @@sound.play
  end
end