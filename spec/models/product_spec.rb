require 'spec_helper'

describe Product do

  let(:company) { FactoryGirl.build(:company) }
  let(:user) { FactoryGirl.create(:user, company: company) }
  let(:product) { FactoryGirl.create(:product, company: company) }
  let(:product_review) { FactoryGirl.create(:product_review, user: user, product: product) }

  describe '#company' do
    it 'returns product company' do
      product.build_draft
      expect(product.draft.company).to eql(product.company)
    end
  end

  describe '#reviews' do
    it 'returns product reviews' do
      product.build_draft
      expect(product.draft.reviews).to_not be_nil
    end
  end

  describe '#to_param' do
    it 'returns product slug' do
      product.build_draft
      expect(product.draft.to_param).to eql(product.slug)
    end
  end

  describe '#rate_it' do
    it 'creates rating record' do
      expect { product.rate_it!(user, 1) }.to change(ProductRating, :count).by(1)
    end
    it 'updates rating_average' do
      expect { product.rate_it!(user, 1) }.to change(product, :rating_average)
    end
  end

  describe '#user_rating' do
    it 'returns zero if user did not rate the product' do
      expect(product.user_rating(user)).to eql(0)
    end
    it 'returns user rating score' do
      product.rate_it!(user, 5)
      expect(product.user_rating(user)).to eql(5)
    end
  end

  describe '#user_preview_id' do
    it 'returns nil if user did not write a review for the product' do
      expect(product.user_review_id(user)).to be_nil
    end
    it 'returns user review id' do
      product_review
      expect(product.user_review_id(user)).to eql(product_review.id)
    end
  end

end
