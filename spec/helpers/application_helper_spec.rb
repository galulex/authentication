require 'spec_helper'

describe ApplicationHelper do

  let(:company) { FactoryGirl.build(:company) }
  let(:user) { FactoryGirl.create(:user, company: company) }
  let(:product) { FactoryGirl.create(:product, company: company) }
  let(:product_rating) { FactoryGirl.create(:product_rating, product: product, user: user) }

  describe '#error_tag' do
    it 'returns error if it exists' do
      expect(helper.error_tag('error')).to match('error')
    end

    it 'returns nil if no error' do
      expect(helper.error_tag(nil)).to be_nil
    end
  end

  describe '#render_title' do
    it 'returns page_title if it is assigned' do
      assign(:page_title, 'title')
      expect(helper.render_title).to eql('title')
    end

    it 'returns page_title if it is not assigned' do
      helper.stub(:params).and_return({ controller: 'test', action: 'test' })
      expect(helper.render_title).to eql(I18n.t("page_titles.test.test"))
    end
  end

  describe '#show_csv_button?' do
    it 'returns false' do
      assign(:report, Reports::Registration.new(start: 1.day.ago, end: Time.now))
      expect(helper.show_csv_button?).to be_false
    end

    it 'returns true' do
      user
      assign(:report,Reports::Registration.new(start: 1.day.ago, end: Time.now))
      helper.stub(:params).and_return({ id: 'registration', commit: true })
      expect(helper.show_csv_button?).to be_true
    end
  end

  describe '#user_product_rating' do
    it 'renders ratings ' do
      product_rating
      expect(helper.user_product_rating(product, user)).to_not be_nil
    end

  end

end
