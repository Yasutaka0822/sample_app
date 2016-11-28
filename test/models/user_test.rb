require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end
  
# setupメソッド内に書かれた処理は、
#各テストが走る直前に実行されます。
#@userはインスタンス変数ですが、
#setupメソッド内で宣言しておけば、
#すべてのテスト内でこのインスタンス変数が
#使えるようになります。
  def setup
    @user = User.new(name: "Yasutaka Shimizu", email: "a1415ys@aiit.ac.jp")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name shoud be present" do
    @user.name = ""
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end
  
  test "name should not be too long" do
    @user.name = "a" * 51 #51文字までの名前
    assert_not @user.valid?
  end
  
  test "email shoud not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
end
