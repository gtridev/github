# encoding: utf-8

module Github
  class Events < API

    # Creates new Gists API
    def initialize(options = {})
      super(options)
    end

    # List all public events
    #
    # = Examples
    #  @github = Github.new
    #  @github.events.public
    #  @github.events.public { |event| ... }
    #
    def public(params={})
      _normalize_params_keys(params)

      response = get("/events", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :public_events :public
    alias :list_public :public
    alias :list_public_events :public

    # List all repository events for a given user
    #
    # = Examples
    #  @github = Github.new
    #  @github.events.repository_events 'user-name', 'repo-name'
    #  @github.events.repository_events 'user-name', 'repo-name' { |event| ... }
    #
    def repository(user_name=nil, repo_name=nil, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _normalize_params_keys(params)

      response = get("/repos/#{user}/#{repo}/events", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :repos :repository
    alias :repo_events :repository
    alias :repository_events :repository
    alias :list_repository_events :repository

    # List all issue events for a given repository
    #
    # = Examples
    #  @github = Github.new
    #  @github.events.issue 'user-name', 'repo-name'
    #  @github.events.issue 'user-name', 'repo-name' { |event| ... }
    #
    def issue(user_name=nil, repo_name=nil, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _normalize_params_keys(params)

      response = get("/repos/#{user}/#{repo}/issues/events", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :issues :issue
    alias :issue_events :issue
    alias :list_issue_events :issue

    # List all public events for a network of repositories
    #
    # = Examples
    #  @github = Github.new
    #  @github.events.network 'user-name', 'repo-name'
    #  @github.events.network 'user-name', 'repo-name' { |event| ... }
    #
    def network(user_name=nil, repo_name=nil, params={})
      _update_user_repo_params(user_name, repo_name)
      _validate_user_repo_params(user, repo) unless user? && repo?
      _normalize_params_keys(params)

      response = get("/networks/#{user}/#{repo}/events", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :repo_network :network
    alias :repository_network :network
    alias :list_repo_network_events :network
    alias :list_repository_network_events :network

    # List all public events for an organization
    #
    # = Examples
    #  @github = Github.new
    #  @github.events.org 'org-name'
    #  @github.events.org 'user-name' { |event| ... }
    #
    def org(org_name, params={})
      _validate_presence_of org_name
      _normalize_params_keys(params)

      response = get("/orgs/#{org_name}/events", params)
      return response unless block_given?
      response.each { |el| yield el }
    end
    alias :organization :org
    alias :list_orgs :org
    alias :list_org_events :org
    alias :list_organization_events :org

  end # Events
end # Github