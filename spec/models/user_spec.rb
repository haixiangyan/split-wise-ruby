require 'rails_helper'

RSpec.describe User, type: :model do
  it '可以带密码创建' do
    user = create :user
    expect(user.password_digest).to_not eq '123456'
    expect(user.id).to be_a Numeric
  end
  it '创建的时候必须有 email' do
    user = build :user, email: ''
    user.validate
    expect(user.errors.details[:email][0][:error]).to eq(:blank)
  end
  it '创建时 email 不能被占用' do
    create :user, email: '1@qq.com'
    user = build :user, email: '1@qq.com'
    user.validate
    expect(user.errors.details[:email][0][:error]).to eq(:taken)
  end
  it '创建之后发欢迎邮件给用户' do
    mailer = spy('mailer')
    allow(UserMailer).to receive(:welcome_email).and_return(mailer)
    User.create email: '1@qq.com', password: '123456', password_confirmation: '123456'
    expect(UserMailer).to have_received(:welcome_email)
    expect(mailer).to have_received(:deliver_later)
  end
  it '邮箱为空字符串则只提示邮箱为空' do
    user = build :user, email: ''
    user.validate
    expect(user.errors.details[:email].length).to eq 1
    expect(user.errors.details[:email][0][:email]).to eq nil
  end
end
