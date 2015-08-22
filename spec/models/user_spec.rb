require 'spec_helper'

describe User do
	before do
		@user = User.new(name: "Example User", email: "user@example.com",
                   password: "foobar", password_confirmation: "foobar")
	end

	# before ブロックは前処理用で、各サンプルが実行される前にそのブロックの中のコードを実行します。
	# このブロックの中のコードを実行します。この場合、Userと初期化用の有効

	subject { @user}

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
  	it { should respond_to(:password_confirmation) }

	# name属性とemail属性の存在をテストします。

	# beforeブロック内では、
	# ただ属性ハッシュをnew name属性とemail属性の存在をテストしいるだけです。
	# これらのテストを追加することで、user.nameやname.emailが正しく動作することを
	# 保証できます。

	# オブジェクトが応答する場合は true が帰ります。

	it { should be_valid }

	describe "when name is not present" do
		before { @user.name = " "}
		it { should_not be_valid }
	end

	describe "When email is not present" do
		before { @user.email = " "}
		it{ should_not be_valid}
	end

	describe "when name is too long" do
		before {@user.name = "a"*51}
		it {should_not be_valid}
	end

	
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        expect(@user).to be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  # 以下は不一致の場合のテスト

  describe "when password doesn't match confirmation" do
  	before { @user.password_confirmation = "mismatch"}
  	it { should_not be_valid}
  end

  describe "return value of authenticase method" do

  	before{ @user.save}
  	let(:found_user){User.find_by(email:@user.email)}
  	#letはローカル変数。


  	    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end


  		






end