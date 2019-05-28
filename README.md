# 概要

現時点、Ruby の trunk に入っている *パターンマッチング* について試したものです

参考
- https://speakerdeck.com/k_tsj/pattern-matching-new-feature-in-ruby-2-dot-7
- https://developer.feedforce.jp/entry/2019/05/17/110000

# 準備

Ruby の 2.7.0-dev をインストール
今回は [asdf](https://github.com/asdf-vm/asdf) を使用

```bash
asdf install ruby 2.7.0-dev
```

# パターンマッチングの書き方

```ruby
case A
in B
  :somthing
else
  :something
end
```

`case ~ in` 記法なんて呼ばれるかもなぁ

# ワクワクするポイント

## 新しい書き方

例) 特定の人物の性別が知りたい

```ruby
arr = [
  { name: :marty,    sex: :male   },
  { name: :doc,      sex: :male   },
  { name: :biff,     sex: :male   },
  { name: :lorraine, sex: :female }
]

# for-in でベタベタに
for val in arr
  case val[:name]
  when :marty
    p val[:sex]
  end
end

# find で抽出
p arr.find { |val| val[:name] == :marty }[:sex]

# case-in
case arr
in [{name: :marty, sex: sex}, *]
  p sex
else
end
```

## Hashの部分一致

```ruby
class Person
  def self.find_by(name:)
    case name
    when :marty
      { name: :marty, sex: :male, age: 17 }
    when :doc
      { name: :doc, sex: :male, age: 65 }
    when :biff
      { name: :biff, sex: :male, age: 48 }
    when :lorraine
      { name: :lorraine, sex: :female, age: 47 }
    end
  end
end

p = Person.find_by(name: :marty)
case p[:sex]
when :male
  p 'man'
when :female
  p 'woman'
end

case Person.find_by(name: :marty)
in { sex: :male }
  p 'man'
in { sex: :female }
  p 'woman'
end


p = Person.find_by(name: :marty)
case p[:sex]
when :male
  p p[:age] < 20 ? 'young man' : 'man'
when :female
  p 'woman'
end

if p[:sex] == :female
  p 'woman'
elsif p[:sex] == :male
  p p[:age] < 20 ? 'young man' : 'man'
end

case Person.find_by(name: :marty)
  in { sex: :male, age: 0..20 }
  p 'young man'
in { sex: :male }
  p 'man'
in { sex: :female }
  p 'woman'
end

case Person.find_by(name: :marty)
in { sex: :male, age: age } if age < 20
  p 'young man'
in { sex: :male }
  p 'man'
in { sex: :female }
  p 'woman'
end
```
