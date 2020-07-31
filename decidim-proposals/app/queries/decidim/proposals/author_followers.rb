# frozen_string_literal: true

module Decidim
  module Proposals
    class AuthorFollowers
      # Initializes the class.
      #
      # authors - An ActiveRecord::Relation or Array of author ids
      def initialize(authors)
        @authors = authors
      end

      # followers.fetch(model.id, model.followers.count)
      def query
        Decidim::Follow
          .where(decidim_followable_type: "Decidim::UserBaseEntity")
          .where(decidim_followable_id: authors)
          .group(:decidim_followable_id)
          .count
      end

      private

      attr_reader :authors
    end
  end
end
