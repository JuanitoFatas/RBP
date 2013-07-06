require 'test/unit'
require './test_unit_extensions'

class VolumeTest < Test::Unit::TestCase
  must "compute volume based on length, width, and height" do
    # defaluts to l=w=h=1
    assert_equal 1, volume

    # when given 1 arg, set l=x, set w,h=1
    x = 6
    assert_equal x, volume(x)

    # when given 2 arg, set l=x, w=y and h=1
    y = 2
    assert_equal x*y, volume(x,y)

    # when given 3 arg, set l=x, w=y, h=z
    z = 7
    assert_equal x*y*z, volume(x,y,z)

    # when given a hash, use :length, :width, :height
    assert_equal x*y*z, volume(length: x, width: y, height: z)
  end
end