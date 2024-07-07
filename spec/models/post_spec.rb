# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Postモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { post.valid? }

    let(:user) { create(:user) }
    let!(:post) { build(:post, user_id: user.id) }

    context "post_imageカラム" do
      it "未登録でないこと", spec_category: "バリデーションとメッセージ表示" do
        post.post_image = nil
        is_expected.to eq false
      end
    end

    context "titleカラム" do
      it "空欄でないこと", spec_category: "バリデーションとメッセージ表示" do
        post.title = ""
        is_expected.to eq false
      end
      it "20文字以下であること: 20文字は〇", spec_category: "バリデーションとメッセージ表示" do
        post.title = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it "20文字以下であること: 21文字は×", spec_category: "バリデーションとメッセージ表示" do
        post.title = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end

    context "captionカラム" do
      it "100文字以下であること: 100文字は〇", spec_category: "バリデーションとメッセージ表示" do
        post.caption = Faker::Lorem.characters(number: 100)
        is_expected.to eq true
      end
      it "100文字以下であること: 101文字は×", spec_category: "バリデーションとメッセージ表示" do
        post.caption = Faker::Lorem.characters(number: 101)
        is_expected.to eq false
      end
    end

    context "bodyカラム" do
      it "2000文字以下であること: 2000文字は〇", spec_category: "バリデーションとメッセージ表示" do
        post.body = Faker::Lorem.characters(number: 2000)
        is_expected.to eq true
      end
      it "2000文字以下であること: 2001文字は×", spec_category: "バリデーションとメッセージ表示" do
        post.body = Faker::Lorem.characters(number: 2001)
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1となっている", spec_category: "基本的なアソシエーション概念と適切な変数設定" do
        expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
