require 'dxruby'

require_relative 'player'
require_relative 'bullet'
require_relative 'enemy'

#画像、音、フォント
font = Font.new(32)
player_img = Image.load("image/player.png")
enemy_img = Image.load("image/enemy.png")
boss_img = Image.load("image/boss.png")
bullet_img = Image.load("image/bullet.png")
back = Image.load("image/back.png")
board = Image.load("image/board.png")

player = Player.new(310, 400, player_img)
enemies = []
bullets = []

timer = 0 
score = 0
t = 0
$boss_stage = 0
boss_life = 10
player.life = 3

#背景スクロール
def show(timer,back)
  t=timer%224*2
  Window.draw(30, 20 + t, back)
  Window.draw(30, t - 428, back)
end

#メインループ
Window.loop do
  show(timer,back)

  ##敵機作成
  if $boss_stage==1
  elsif score % 30 == 0 && score != 0 && $boss_stage == 0
	$boss_stage = 1
	enemies << Enemy.new(50, 0, boss_img,10)
  elsif(timer%60 == 0)
	ex = rand(20..400)
	angle= Math.atan2(player.y, player.x-ex)
  	enemies << Enemy.new(ex,angle,enemy_img,1)
  elsif(timer%20 == 0)
	ex = rand(20..400)
	angle = rand(0..Math::PI)
	enemies << Enemy.new(ex,angle,enemy_img,1)
  end

  #弾発射
  if Input.key_push?(K_Z) 
	bullets << Bullet.new(player.x,player.y,bullet_img)
  end

  #移動
  player.update #player
  
  enemies.size.times{ |n| #enemy
	if $boss_stage == 0
	  enemies[n].update
	elsif enemies[n].image != boss_img
	  enemies[n].hit
	  $boss_stage = 1
	end
  }

  bullets.size.times{ |n| #bullet
    bullets[n].update
  }

  #表示
  player.draw
  Sprite.draw(bullets)
  Sprite.draw(enemies)
  Window.draw_font(32, 20, "スコア：#{score}", font)
  Window.draw_font(32, 52, "ライフ：#{player.life}", font) 
  Window.draw(0, 0, board)

  #あたり判定
  Sprite.check(player, enemies)
  if Sprite.check(bullets, enemies)
	score += 1
  end
  Sprite.clean(enemies)
  Sprite.clean(bullets)
  

  #ゲーム終了
  if player.life == 0 && t == 0
	t=timer
  end
  if timer-t > 50 && t != 0
  	break
  end

  timer += 1 # 追加
end