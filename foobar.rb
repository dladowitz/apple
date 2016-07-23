class FooBar
  def check_number(number)
    number = number.to_i if number.instance_of?(String)
    return unless valid_argument?(number)
    result = "#{number}: "
    result << "foo" if number % 3 == 0
    result << "bar" if number % 5 == 0
    p result
  end

  private

  def valid_argument?(number)
    # puts "number: #{number}"
    if number.instance_of?(Fixnum) && number >= 1 && number <= 100
      return true
    else
      p "Only numbers between 1 and 100 are allowed"
      return false
    end
  end
end



puts "================ Running Tests ================"
require "minitest/autorun"
describe 'FooBar' do
  it 'Exists as a class' do
    foobar = FooBar.new
    assert_instance_of(FooBar, foobar, msg = nil)
  end
end

describe "#check_number" do
  before { @foobar = FooBar.new }

  it "returns only a number if it’s not divisible by 3 or 5" do
    assert_output(/2:/){ @foobar.check_number(2) }
  end

  it "returns 'foo' if it’s divisible by 3" do
    assert_output(/3: foo/){ @foobar.check_number(3) }
  end

  it "returns 'bar' if it’s divisible by 5" do
    assert_output(/5: bar/){ @foobar.check_number(5) }
  end

  it "returns '<number>: foo' if it’s divisible by 3" do
    assert_output(/15: foobar/){ @foobar.check_number(15) }
  end

  it "returns an error message if the arguments are out of bound numbers" do
    assert_output(/Only numbers between 1 and 100 are allowed/){@foobar.check_number(0)}
    assert_output(/Only numbers between 1 and 100 are allowed/){@foobar.check_number(200)}
    assert_output(/Only numbers between 1 and 100 are allowed/){@foobar.check_number(-20)}
  end

  it "parses strings which are integers between 1 and 100" do
    assert_output(/15: foobar/){@foobar.check_number("15")}
  end

  it "returns an error message for non integers" do
    assert_output(/Only numbers between 1 and 100 are allowed/){@foobar.check_number([1])}
    assert_output(/Only numbers between 1 and 100 are allowed/){@foobar.check_number({test: 1})}
    assert_output(/Only numbers between 1 and 100 are allowed/){@foobar.check_number("Hello")}
  end
end
