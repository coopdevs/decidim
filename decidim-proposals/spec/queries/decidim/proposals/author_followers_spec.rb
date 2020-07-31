# frozen_string_literal: true

require "spec_helper"

describe Decidim::Proposals::AuthorFollowers do
  let(:author) { create(:user, :confirmed) }
  let(:other_author) { create(:user, :confirmed) }
  let(:authors) { Decidim::UserBaseEntity.where(id: [author.id, other_author.id]) }

  before do
    follower = create(:user)
    create(:follow, followable: author, user: follower)

    follower = create(:user)
    create(:follow, followable: author, user: follower)

    follower = author
    create(:follow, followable: other_author, user: follower)
  end

  it "returns the count of followers of an author" do
    author_followers = described_class.new(authors)
    expect(author_followers.query).to eq(author.id => 2, other_author.id => 1)
  end
end
