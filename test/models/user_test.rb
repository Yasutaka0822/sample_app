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
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@examplel.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  
  #@userと同じメールアドレスのユーザーは作成できないことを、
  #@user.dupを使ってテストしています。
  #dupは、同じ属性を持つデータを複製するためのメソッドです。
  #@userを保存した後では、複製されたユーザーのメールアドレスが
  #既にデータベース内に存在するため、ユーザの作成は無効になるはずです。
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
end
