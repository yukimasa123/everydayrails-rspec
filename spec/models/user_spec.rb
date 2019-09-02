require 'rails_helper'

RSpec.describe User, type: :model do
  # 姓、名、メール、パスワードがあれば有効な状態であること
  it "is valid with a first name, last name, email, and password" do
    user = User.new(
      first_name: "Aaron",
      last_name: "Sumner",
      email: "test@example.com",
      password: "password",
    )
    expect(user).to be_valid
  end

  # 名が無ければ無効な状態であること
  it "is invalid without a first name" do
    user = User.new(first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  # 姓が無ければ無効な状態であること
  it "is invalid without a last name" do
    user = User.new(last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  # メールアドレスが無ければ無効な状態であること
  it "is invalid without an email address" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate emailaddress" do
    User.create(
      first_name: "Joe",
      last_name: "Tester",
      email: "test@example.com",
      password: "password",
    )
    user = User.new(
      first_name: "Jone",
      last_name: "Tester",
      email: "test@example.com",
      password: "password",
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  # ユーザーのフルネールを文字列として返すこと
  it "retruns a user's full name as a string" do
    user = User.new(
      first_name: "John",
      last_name: "Doe",
      email: "test@example.com",
    )

    expect(user.name).to eq "John Doe"
  end
end
