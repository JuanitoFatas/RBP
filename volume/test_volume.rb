require 'test/unit'
require_relative '../test_unit_extensions'

def volume(*args)
  if Hash === args.first
    x,y,z = [:length,:width,:height].map { |e| args.first[e] || 1 }
  else
    x,y,z = 3.times.map { |i| args[i] || 1 }
  end
  x*y*z
end

class VolumeTest < Test::Unit::TestCase
  must "return 1 by defalut if no arguments are given" do
    # defaluts to l=w=h=1
    assert_equal 1, volume
  end

  must "set l=x, set w,h = 1 when given 1 numeric argument" do
    # when given 1 arg, set l=x, set w,h=1
    x = 6
    assert_equal x, volume(x)
  end

  must "set l=x, w=y, and h = 1 when given 2 arguments" do
    # when given 2 arg, set l=x, w=y and h=1
    x, y = 6, 2
    assert_equal x*y, volume(x,y)
  end

  must "set l=x, w=y, and h=z when given 3 arguments" do
    # when given 3 arg, set l=x, w=y, h=z
    x, y, z = 6, 2, 7
    assert_equal x*y*z, volume(x,y,z)
  end

  must "use :length, :width, and :height when given a hash argument" do
    x, y, z = 6, 2, 7
    assert_equal x*y*z, volume(length: x, width: y, height: z)
  end
end
