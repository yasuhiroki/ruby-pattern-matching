require 'benchmark'
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

def bench(n)
  j = JSON.parse(J, symbolize_names: true)

  puts "n=#{n}"
  Benchmark.benchmark("\t" + Benchmark::CAPTION) do |x|
    x.report("value") do
      1.upto(n) do
        case j
          in { owner: { login: "ruby" }, url: }
        end
      end
    end
    x.report("regexp") do
      1.upto(n) do
        case j
          in { owner: { login: /^r.*/ }, url: }
        end
      end
    end
    x.report("lambda") do
      1.upto(n) do
        case j
          in { owner: { login: -> v { v[0] == "r" } }, url: }
        end
      end
    end
    x.report("in-if") do
      1.upto(n) do
        case j
          in { owner: { login: }, url: } if login == "ruby"
        end
      end
    end



    x.report("when") do
      1.upto(n) do
        case j[:owner][:login]
        when "ruby"
          url = j[:owner][:url]
        end
      end
    end

    x.report("if") do
      1.upto(n) do
        if j[:owner][:login] == "ruby"
          url = j[:owner][:url]
        end
      end
    end
  end
end

n = 0
bench(n)

puts

n = 1_000
bench(n)

puts

n = 100_000
bench(n)

puts

n = 1_000_000
bench(n)
