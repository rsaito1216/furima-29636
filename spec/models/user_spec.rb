require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "nicknameとemail、passwordとpassword_confirmation、last_nameとfirst_name、last_name_kanaとfirst_name_kana、birth_dateが存在すれば登録できる" do
        expect(@user).to be_valid
      end
      it "passwordが半角英数字混合で6文字以上であれば登録できること" do
        @user.password = "abc123"
        @user.password_confirmation = "abc123"
        expect(@user).to be_valid
      end
      it "last_nameが全角入力であれば登録できること" do
        @user.last_name = "あイ宇"
        expect(@user).to be_valid
      end
      it "first_nameが全角入力であれば登録できること" do
        @user.first_name = "あイ宇"
        expect(@user).to be_valid
      end
      it "last_name_kanaが全角カナ入力であれば登録できること" do
        @user.last_name_kana = "アイウ"
        expect(@user).to be_valid
      end
      it "first_name_kanaが全角カナ入力であれば登録できること" do
        @user.first_name_kana = "アイウ"
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it "nicknameが空だと登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank", "Email @が入力されていません。")
      end
      it "emailに@が含まれていないと登録できない" do
        @user.email = "aaacom"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid", "Email @が入力されていません。")
      end
      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank", "Password は半角、英数字を混ぜて入力してください。", "Password confirmation doesn't match Password")
      end
      it "passwordが5文字以下であれば登録できない" do
        @user.password = "00000"
        @user.password_confirmation = "00000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)", "Password は半角、英数字を混ぜて入力してください。")
      end
      it "passwordが6文字以上であっても半角数字だけでは登録できない" do
        @user.password = "1234567"
        @user.password_confirmation = "1234567"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角、英数字を混ぜて入力してください。")
      end
      it "passwordが6文字以上であっても半角英字だけでは登録できない" do
        @user.password = "abcdefg"
        @user.password_confirmation = "abcdefg"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password は半角、英数字を混ぜて入力してください。")
      end
      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it "last_nameが空では登録できない" do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", "Last name は全角（漢字・ひらがな・カタカナ）で入力してください。")
      end
      it "last_nameが全角入力でなければ登録できない" do
        @user.last_name = "ｱｲｳ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name は全角（漢字・ひらがな・カタカナ）で入力してください。")
      end
      it "first_nameが空では登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name は全角（漢字・ひらがな・カタカナ）で入力してください。")
      end
      it "first_nameが全角入力でなければ登録できない" do
        @user.first_name = "ｱｲｳ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name は全角（漢字・ひらがな・カタカナ）で入力してください。")
      end
      it "last_name_kanaが空では登録できない" do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", "Last name kana は全角カタカナで入力してください。")
      end
      it "last_name_kanaが全角カナでなければ登録できない" do
        @user.last_name_kana = "ｱｲｳあいう"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana は全角カタカナで入力してください。")
      end
      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana は全角カタカナで入力してください。")
      end
      it "first_name_kanaが全角カナでなければ登録できない" do
        @user.first_name_kana = "ｱｲｳあいう"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana は全角カタカナで入力してください。")
      end
      it "birth_dateが空では登録できない" do
        @user.birth_date = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end
    end
  end
end