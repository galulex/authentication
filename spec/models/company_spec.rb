require 'spec_helper'

describe Company do

  let(:company) { FactoryGirl.build(:company) }
  let(:draft) { FactoryGirl.build(:company_draft, company: company, status: 'draft') }

  describe '#company_status' do
    it 'returns company status' do
      expect(company.company_status).to eql(:approved)
    end

    it 'returns company draft status' do
      company.draft = draft
      expect(company.company_status).to eql('draft')
    end
  end

  describe '#pending?' do
    it 'returns nil if no company draft' do
      expect(company).to_not be_pending
    end

    it 'returns false if company draft is not pending' do
      expect(draft.company).to_not be_pending
    end

    it 'returns true if company draft is pending' do
      draft.submit
      expect(draft.company).to be_pending
    end
  end

  describe '#published?' do
    it 'returns false if company is not published' do
      company.status = 'draft'
      expect(company).to_not be_published
    end

    it 'returns true if company is published' do
      expect(company).to be_published
    end
  end

#   describe '#to_param' do
#     it 'returns company id' do
#       expect(draft.to_param).to eql(company.id)
#     end
#   end

end
