class Cell
  attr_reader :live

  def initialize(opt={})
    @live = opt.fetch(:live, true)
  end

  def live?
    @live
  end

  def live
    @live = true
    self
  end

  def survive
    live
  end

  def die
    @live = false
    self
  end

  def died?
    !live?
  end
end
