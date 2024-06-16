# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Userモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { user.valid? }

    let!(:other_user) { create(:user) }
    let(:user) { build(:user) }

    context "last_nameカラム" do
      it "空欄でないこと", spec_category: "バリデーションとメッセージ表示" do
        user.last_name = ""
        is_expected.to eq false
      end
    end
    
    context "first_nameカラム" do
      it "空欄でないこと", spec_category: "バリデーションとメッセージ表示" do
        user.first_name = ""
        is_expected.to eq false
      end
    end
    
    context "canonical_nameカラム" do
      it "空欄でないこと", spec_category: "バリデーションとメッセージ表示" do
        user.canonical_name = ""
        is_expected.to eq false
      end
      it "半角英数字であること: 半角英数字は〇", spec_category: "バリデーションとメッセージ表示" do
        user.canonical_name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it "半角英数字以外ではないこと: 半角記号-は×", spec_category: "バリデーションとメッセージ表示" do
        user.canonical_name = Faker::Lorem.characters(number: 15) + "-"
        is_expected.to eq false
      end
      it "半角英数字以外ではないこと: 半角記号_は×", spec_category: "バリデーションとメッセージ表示" do
        user.canonical_name = Faker::Lorem.characters(number: 15) + "_"
        is_expected.to eq false
      end
      it "半角英数字以外ではないこと: 全角は×", spec_category: "バリデーションとメッセージ表示" do
        user.canonical_name = Faker::Lorem.characters(number: 15) + "テスト"
        is_expected.to eq false
      end
      it "1文字以上であること: 1文字は〇", spec_category: "バリデーションとメッセージ表示" do
        user.canonical_name = Faker::Lorem.characters(number: 1)
        is_expected.to eq true
      end
      it "20文字以下であること: 20文字は〇", spec_category: "バリデーションとメッセージ表示" do
        user.canonical_name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it "20文字以下であること: 21文字は×", spec_category: "バリデーションとメッセージ表示" do
        user.canonical_name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
      it "一意性があること", spec_category: "バリデーションとメッセージ表示" do
        user.canonical_name = other_user.canonical_name
        is_expected.to eq false
      end
    end
    
    context "public_nameカラム" do
      it "空欄でないこと", spec_category: "バリデーションとメッセージ表示" do
        user.public_name = ""
        is_expected.to eq false
      end
    end

    context "introductionカラム" do
      it "50文字以下であること: 200文字は〇", spec_category: "バリデーションとメッセージ表示" do
        user.introduction = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it "50文字以下であること: 201文字は×", spec_category: "バリデーションとメッセージ表示" do
        user.introduction = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Postモデルとの関係" do
      it "1:Nとなっている", spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
  end
end