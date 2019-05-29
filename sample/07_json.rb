require 'json'

J = <<'EOS'
{
  "id": 538746,
  "node_id": "MDEwOlJlcG9zaXRvcnk1Mzg3NDY=",
  "name": "ruby",
  "full_name": "ruby/ruby",
  "private": false,
  "owner": {
    "login": "ruby",
    "id": 210414,
    "node_id": "MDEyOk9yZ2FuaXphdGlvbjIxMDQxNA==",
    "avatar_url": "https://avatars3.githubusercontent.com/u/210414?v=4",
    "gravatar_id": "",
    "url": "https://api.github.com/users/ruby",
    "html_url": "https://github.com/ruby",
    "followers_url": "https://api.github.com/users/ruby/followers",
    "following_url": "https://api.github.com/users/ruby/following{/other_user}",
    "gists_url": "https://api.github.com/users/ruby/gists{/gist_id}",
    "starred_url": "https://api.github.com/users/ruby/starred{/owner}{/repo}",
    "subscriptions_url": "https://api.github.com/users/ruby/subscriptions",
    "organizations_url": "https://api.github.com/users/ruby/orgs",
    "repos_url": "https://api.github.com/users/ruby/repos",
    "events_url": "https://api.github.com/users/ruby/events{/privacy}",
    "received_events_url": "https://api.github.com/users/ruby/received_events",
    "type": "Organization",
    "site_admin": false
  },
  "html_url": "https://github.com/ruby/ruby",
  "description": "The Ruby Programming Language [mirror]",
  "fork": false,
  "url": "https://api.github.com/repos/ruby/ruby",
  "forks_url": "https://api.github.com/repos/ruby/ruby/forks"
}
EOS

j = JSON.parse(J, symbolize_names: true)

case j
  in { owner: { login: "ruby" }, url: }
    p url
end

case j
  in { owner: { login: /^r.*/ }, url: }
    p url
end

case j
  in { owner: { login: -> v { v[0] == "r" } }, url: }
    p url
end
