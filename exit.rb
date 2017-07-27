class Exit
  attr_accessor(:x, :y, :z)

  def initialize(spawn_x,spawn_y)
    @x = spawn_x
    @y = spawn_y
    @z = 1
    @exit_anim_arr = Gosu::Image.load_tiles("img/blue1anim.png", 64, 64)
    @anim_frame = 0
    @exit_cur_img = @exit_anim_arr[3]
    @anim_timer = 150
  end

  def update
    if (Gosu.milliseconds % @anim_timer <= 16.67)
      @exit_cur_img = @exit_anim_arr[@anim_frame]
      if ((@anim_frame + 1) > 7)
        @anim_frame = 0
      else
        @anim_frame += 1
      end
    end
  end

  def draw
    @exit_cur_img.draw(@x,@y,@z)
  end

end
