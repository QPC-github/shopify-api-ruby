# typed: strict
# frozen_string_literal: true

module ShopifyAPI
  class Comment < ShopifyAPI::RestWrappers::Base
    extend T::Sig

    @prev_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)
    @next_page_info = T.let(Concurrent::ThreadLocalVar.new { nil }, Concurrent::ThreadLocalVar)

    @has_one = T.let({}, T::Hash[Symbol, Class])
    @has_many = T.let({}, T::Hash[Symbol, Class])
    @paths = T.let([
      {http_method: :get, operation: :get, ids: [], path: "comments.json"},
      {http_method: :get, operation: :count, ids: [], path: "comments/count.json"},
      {http_method: :get, operation: :get, ids: [:id], path: "comments/<id>.json"},
      {http_method: :put, operation: :put, ids: [:id], path: "comments/<id>.json"},
      {http_method: :post, operation: :post, ids: [], path: "comments.json"},
      {http_method: :post, operation: :spam, ids: [:id], path: "comments/<id>/spam.json"},
      {http_method: :post, operation: :not_spam, ids: [:id], path: "comments/<id>/not_spam.json"},
      {http_method: :post, operation: :approve, ids: [:id], path: "comments/<id>/approve.json"},
      {http_method: :post, operation: :remove, ids: [:id], path: "comments/<id>/remove.json"},
      {http_method: :post, operation: :restore, ids: [:id], path: "comments/<id>/restore.json"}
    ], T::Array[T::Hash[String, T.any(T::Array[Symbol], String, Symbol)]])

    sig { returns(T.nilable(Integer)) }
    attr_reader :article_id
    sig { returns(T.nilable(String)) }
    attr_reader :author
    sig { returns(T.nilable(Integer)) }
    attr_reader :blog_id
    sig { returns(T.nilable(String)) }
    attr_reader :body
    sig { returns(T.nilable(String)) }
    attr_reader :body_html
    sig { returns(T.nilable(String)) }
    attr_reader :created_at
    sig { returns(T.nilable(String)) }
    attr_reader :email
    sig { returns(T.nilable(Integer)) }
    attr_reader :id
    sig { returns(T.nilable(String)) }
    attr_reader :ip
    sig { returns(T.nilable(String)) }
    attr_reader :published_at
    sig { returns(T.nilable(String)) }
    attr_reader :status
    sig { returns(T.nilable(String)) }
    attr_reader :updated_at
    sig { returns(T.nilable(String)) }
    attr_reader :user_agent

    class << self
      sig do
        params(
          session: Auth::Session,
          id: T.any(Integer, String),
          fields: T.untyped
        ).returns(T.nilable(Comment))
      end
      def find(
        session:,
        id:,
        fields: nil
      )
        result = base_find(
          ids: {id: id},
          params: {fields: fields},
          session: session,
        )
        T.cast(result[0], T.nilable(Comment))
      end

      sig do
        params(
          session: Auth::Session
        ).returns(T.untyped)
      end
      def delete(session:)
        request(
          http_method: :delete,
          operation: :delete,
          session: session,
          path_ids: {},
          params: {},
        )
      end

      sig do
        params(
          session: Auth::Session,
          limit: T.untyped,
          since_id: T.untyped,
          created_at_min: T.untyped,
          created_at_max: T.untyped,
          updated_at_min: T.untyped,
          updated_at_max: T.untyped,
          published_at_min: T.untyped,
          published_at_max: T.untyped,
          fields: T.untyped,
          published_status: T.untyped,
          status: T.untyped,
          kwargs: T.untyped
        ).returns(T::Array[Comment])
      end
      def all(
        session:,
        limit: nil,
        since_id: nil,
        created_at_min: nil,
        created_at_max: nil,
        updated_at_min: nil,
        updated_at_max: nil,
        published_at_min: nil,
        published_at_max: nil,
        fields: nil,
        published_status: nil,
        status: nil,
        **kwargs
      )
        response = request(
          http_method: :get,
          operation: :get,
          session: session,
          path_ids: {},
          params: {limit: limit, since_id: since_id, created_at_min: created_at_min, created_at_max: created_at_max, updated_at_min: updated_at_min, updated_at_max: updated_at_max, published_at_min: published_at_min, published_at_max: published_at_max, fields: fields, published_status: published_status, status: status}.merge(kwargs).compact,
        )

        result = create_instances_from_response(response: response, session: session)
        T.cast(result, T::Array[Comment])
      end

      sig do
        params(
          session: Auth::Session,
          created_at_min: T.untyped,
          created_at_max: T.untyped,
          updated_at_min: T.untyped,
          updated_at_max: T.untyped,
          published_at_min: T.untyped,
          published_at_max: T.untyped,
          published_status: T.untyped,
          status: T.untyped,
          kwargs: T.untyped
        ).returns(T.untyped)
      end
      def count(
        session:,
        created_at_min: nil,
        created_at_max: nil,
        updated_at_min: nil,
        updated_at_max: nil,
        published_at_min: nil,
        published_at_max: nil,
        published_status: nil,
        status: nil,
        **kwargs
      )
        request(
          http_method: :get,
          operation: :count,
          session: session,
          path_ids: {},
          params: {created_at_min: created_at_min, created_at_max: created_at_max, updated_at_min: updated_at_min, updated_at_max: updated_at_max, published_at_min: published_at_min, published_at_max: published_at_max, published_status: published_status, status: status}.merge(kwargs).compact,
          entity: nil,
        )
      end

    end

    sig do
      params(
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def spam(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :spam,
        session: @session,
        path_ids: {id: @id},
        params: {}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

    sig do
      params(
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def not_spam(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :not_spam,
        session: @session,
        path_ids: {id: @id},
        params: {}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

    sig do
      params(
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def approve(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :approve,
        session: @session,
        path_ids: {id: @id},
        params: {}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

    sig do
      params(
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def remove(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :remove,
        session: @session,
        path_ids: {id: @id},
        params: {}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

    sig do
      params(
        body: T.nilable(T.untyped),
        kwargs: T.untyped
      ).returns(T.untyped)
    end
    def restore(
      body: nil,
      **kwargs
    )
      self.class.request(
        http_method: :post,
        operation: :restore,
        session: @session,
        path_ids: {id: @id},
        params: {}.merge(kwargs).compact,
        entity: self,
        body: body,
      )
    end

  end
end
