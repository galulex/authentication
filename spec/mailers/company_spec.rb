require "spec_helper"

describe Company do
  describe "submitted" do
    let(:mail) { Company.submitted }

    it "renders the headers" do
      mail.subject.should eq("Submitted")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "declined" do
    let(:mail) { Company.declined }

    it "renders the headers" do
      mail.subject.should eq("Declined")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "published" do
    let(:mail) { Company.published }

    it "renders the headers" do
      mail.subject.should eq("Published")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
